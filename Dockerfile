# Use the official Node.js image as the base image for building
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the React application
RUN npm run build

# Use the official Nginx image to serve the built application
FROM nginx:stable-alpine

# Copy the built React app from the previous stage to the Nginx web root
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the container
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
