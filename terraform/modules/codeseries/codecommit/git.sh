#!/bin/sh
# clone the repository
git clone https://${aws_codecommit_repository.jujy_log_repo.clone_url_http}

# add credentials to the Git config
git config --global credential.helper '!aws codecommit credential-helper ${aws_codecommit_repository.jujy_log_repo.repository_name}'
git config --global credential.UseHttpPath true

# add some code to the repository
git init
cd ../../../../jujy-log/
git add .
git commit -m "feat: jujy-log project"
git push origin main
