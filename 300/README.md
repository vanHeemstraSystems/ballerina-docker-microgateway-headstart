# 300 - How to deploy the service with Docker

In order to create an image linked to our service that is handled by Docker we will need to keep the following aspects of the code above in mind:

- We have indicated the service port to expose to the outside world.

- We have included the configuration of the image to be created.

In order to create the image we will need to execute the following command:

```$ bal build HTTPService.bal```

And we can start our service thanks to Docker using the following command:

```$ docker run -d -p 9091:9091 com.chakray.example/example:v1.0```

Note: Docker needs to have been installed for the above command to succeed. See also https://github.com/vanHeemstraSystems/docker-quick-start-headstart/blob/main/1300/README.md
