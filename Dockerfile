# Build environment
FROM node:12.8.0 as builder
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY . .
RUN npm install
RUN npm run build
EXPOSE 3000
CMD [ "npm", "run", "start" ]

# Production environment
# FROM nginx:1.16.0-alpine
# RUN rm -rf /etc/nginx/conf.d
# COPY conf /etc/nginx
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

FROM nginx:1.16.0-alpine
COPY --from=builder /app/.next/server/pages /usr/share/nginx/html
RUN rm -rf /etc/nginx/conf.d
COPY conf /etc/nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"] 
VOLUME /var/log/nginx