# NOTE: A project.lock.json file must be included, otherwise you will get the following error:
#       Project app does not have a lock file

# Build the image:
# docker build -t tonysneed/dotnet-helloweb-watch .

# Create and run a container:
# docker run -d -p 5000:5000 --name dotnet-helloweb-watch -v "${PWD}:/app" tonysneed/dotnet-helloweb-watch

FROM tonysneed/dotnet-preview:1.0.0-rc2-002673

MAINTAINER Anthony Sneed

# Set environment variables
ENV ASPNETCORE_URLS="http://*:5000"
ENV ASPNETCORE_ENVIRONMENT="Staging"

# Required for dotnet-watch to detect file changes
ENV USE_POLLING_FILE_WATCHER=1

# Copy files to app directory
COPY . /app

# Set working directory
WORKDIR /app

# Restore NuGet packages
RUN ["dotnet", "restore"]

# Open up port
EXPOSE 5000

# Specify a url with a wildcard for the host name
ENTRYPOINT ["/bin/bash", "-c", "dotnet watch"]