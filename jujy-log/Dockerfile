FROM node:16.13.2-alpine

WORKDIR /usr/src/app

#의존성 설치를 위해 package.json, yarn.lock 복사 
COPY package.json ./
COPY yarn.lock ./

#env setting 
ENV NOTION_PAGE_ID f9da849b1e0c435ea7c3cc90b91a8ae0

#의존성 설치
RUN yarn

COPY . .

#next.js application build
RUN yarn build

#container port setting 
EXPOSE 3000

#appplication execute
CMD ["yarn", "start"]