
# ---- Production Docker build ---------------

# FROM node:13.12.0-alpine as build

# WORKDIR /app

# ENV PATH /app/node_modules/.bin:$PATH
# ENV REACT_APP_BG_COLOR=#9cacff

# COPY package.json ./
# COPY package-lock.json ./

# RUN npm ci --silent
# RUN npm install react-scripts@3.4.1 -g --silent

# COPY . ./

# RUN npm run build

# FROM nginx:stable-alpine
# COPY --from=build /app/build /usr/share/nginx/html
# # COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

# pull official base image
FROM node:13.12.0-alpine

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH
ENV REACT_APP_BG_COLOR=#9cacff

# install app dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent

# add app
COPY . ./

# start app
CMD ["npm", "start"]