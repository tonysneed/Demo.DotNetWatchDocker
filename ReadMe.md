# DotNet Watch Docker Demo

1. First install **Docker Toolbox**: https://www.docker.com/products/docker-toolbox

2. Build an image based on the latest .NET CLI bits

    ```
    cd Demo.DotNetWatchDocker
    docker build -t tonysneed/dotnet-helloweb-watch .
    ```

3. Create and run a Docker container based on the image

    ```
    docker run -d -p 5000:5000 --name dotnet-helloweb-watch -v "${PWD}:/app" tonysneed/dotnet-helloweb-watch
    ```

4. Open a browser: `http://192.168.99.100:5000`
  - You should see: **Hello World!**

5. You can now modify the code in `Startup.Configure` to return a different string
  - If you refresh the browser, you should see the new string displayed

