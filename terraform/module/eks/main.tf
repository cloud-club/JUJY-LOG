#creating eks cluster by local-exec
resource "null_resource" "create_eks_cluster" {

  provisioner "local-exec" {
    # create eks cluster by cluster config yml
    command = "eksctl create cluster -f ${var.eks_cluster_config_file_path}"
  }

  provisioner "local-exec" {
    # add configmap to aws-auth : codebuild_role & eks_kubectl_role
     command = <<EOF
      eksctl create iamidentitymapping --cluster=${var.eks_cluster_name} --arn=arn:aws:iam::${var.aws_account_id}:role/${var.codebuild_role_name} --username=${var.codebuild_role_name} --group=system:masters
      eksctl create iamidentitymapping --cluster=${var.eks_cluster_name} --arn=arn:aws:iam::${var.aws_account_id}:role/${var.eks_kubectl_role_name} --username=${var.codebuild_role_name} --group=system:masters
    EOF
  }

  provisioner "local-exec" {
     # create k8s objects by manifest yml
     command = <<EOF
      kubectl create -f ${var.k8s_deployment_file_path}
      kubectl create -f  ${var.k8s_service_file_path}
      kubectl create -f ${var.k8s_ingress_file_path}
    EOF
  }

  provisioner "local-exec" {
    # install aws loadbalancer controller
     command = <<EOF
      CLUSTER_VPC_ID=$(aws eks describe-cluster --name ${var.eks_cluster_name} --query cluster.resourcesVpcConfig.vpcId --output text)
      helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=${var.eks_cluster_name} --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller --set region=${var.aws_default_region} --set vpcId=$CLUSTER_VPC_ID
    EOF
  }

}