# LTS image from docker hub for the build phase.
FROM node:12-alpine as builder

# Create app directory.
WORKDIR /app

# A wildcard is used to ensure the package.json has been copied to the image.
COPY package.json /app

# Install dependencies.
RUN npm install

# Copy local files to the docker image.
COPY ./public /app/public
COPY ./src /app/src

# Build the application.
RUN npm run build


# The run phase.
# Take the nginx image from docker hub.
FROM nginx

# Expose the image ports for accessing through them outside the image.
EXPOSE 80

# Copy the built app.
COPY --from=builder /app/build /usr/share/nginx/html
