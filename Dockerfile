# Stage 0: 基于 Node.js 构建 Angular 应用
FROM node:10-alpine as node
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
ARG TARGET=ng-deploy
RUN npm run ${TARGET}

# Stage 1: 基于 Nginx 部署生产环境
FROM nginx:1.13
COPY --from=node /app/dist/ /usr/share/nginx/html
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
EXPOSE 80