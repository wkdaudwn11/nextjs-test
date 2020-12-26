# Dockerfile
# FROM node:12.8.0 as builder
# WORKDIR /app
# ENV PATH /app/node_modules/.bin:$PATH
# COPY package.json /app/package.json
# RUN npm install
# COPY . .
# RUN npx next build
# EXPOSE 3000
# CMD [ "npx", "next", "start" ]

# Build environment
FROM node:12.8.0 as builder
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json
RUN npm install --silent
COPY . .
# RUN npm run build
EXPOSE 3000
CMD [ "npm", "run", "start" ]

# Production environment
# FROM nginx:1.16.0-alpine
# RUN rm -rf /etc/nginx/conf.d
# COPY conf /etc/nginx
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]