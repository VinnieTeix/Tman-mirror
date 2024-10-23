# Dockerfile for Vue/Vite
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Copy the rest of the application code
COPY . .

# Install dependencies
RUN npm install

# Build the application
RUN npm run build

# Expose the port the app runs on
EXPOSE 5173

# Command to serve the app
CMD ["npm", "run", "dev","--host"]
