# docker build -t tonysneed/dotnet-watch-aspnet .

# docker run -d -p 5000:5000 --name dotnet-watch-aspnet tonysneed/dotnet-watch-aspnet

FROM microsoft/dotnet-preview

MAINTAINER Anthony Sneed

# ASPNET_ENV appears to be invalid
#ENV ASPNET_ENV="Development"

# Adds location of global commands to path so that they can be run
ENV PATH $PATH:$DNX_USER_HOME/bin

# TODO: Required for dnx-watch to detect file changes on the mounted volume
ENV MONO_MANAGED_WATCHER 1

COPY . /app
WORKDIR /app

RUN ["dotnet", "restore"]

# Change ownership of created files to main user on host
# Required to prevent error: 'Project app does not have a lock file'
RUN chown -R 1000:1000 project.lock.json

# Must mount volumes after changing ownership
VOLUME ./:/app
VOLUME nuget:/root/.nuget

EXPOSE 5000

# Specify a url with a wildcard for the host name
ENTRYPOINT ["/bin/bash", "-c", "dotnet watch -- server.urls=http://*:5000"]