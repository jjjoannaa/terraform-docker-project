FROM nginx:alpine

LABEL description="Automated Infrastructure Validation Application"

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]