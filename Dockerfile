# Build phase
FROM node:22-alpine as builder
# Switch to node user
USER node
# Create app directory
WORKDIR '/home/node/app'
# Copy package.json and install dependencies
COPY --chown=node:node ./package.json .
RUN npm install
# Copy the rest of the application
COPY --chown=node:node ./ .
# Build the application
RUN npm run build

# Run phase
FROM nginx
# Copy the built application from the builder stage
COPY --from=builder /home/node/app/dist /usr/share/nginx/html