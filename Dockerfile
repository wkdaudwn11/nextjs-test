# Dockerfile
FROM node:12 as base
WORKDIR /app
COPY package.json ./
RUN npm install
ENV CONTINUOUS_INTEGRATION=1
ENV NODE_ENV=production
COPY . .
RUN npm run build
EXPOSE 3000
CMD [ "npm", "start" ]

# Production environment
# FROM nginx:1.16.0-alpine
# RUN rm -rf /etc/nginx/conf.d
# COPY conf /etc/nginx
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]