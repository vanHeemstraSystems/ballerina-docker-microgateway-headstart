# 500 - How to Deploy the Docker

When using Docker, we will be able to make a fast deployment, without the need for manual binary downloads or extra configurations, offering a more modern approach and focusing our services on cloud deployments. For this, we will have to execute the following command:

```
docker run --net=wso2_nw --name=dockerBookAPI -d -v /temp/bookAPI/target:/home/exec/ -p 9095:9095 -p 9090:9090 -e project="bookAPI"  wso2/wso2micro-gw:3.0.1
```

Once the two images have been obtained, all we have to do is verify that the two resources work correctly and that both the service and the Microgateway are doing their job. We can do this test with the following commands: 

```
curl -X GET http://localhost:9090/bookAPI/v1/book/1

curl -X POST http://localhost:9090/bookAPI/v1/book -H 'Content-Type: application/json'
-d '{"book":{"id":1,"name":"WSO2 Developer´s Guide","author":"Ramon Garrido, Fidel Prieto"}}'
```
Note: It is important to correctly enter the path where our compiled API is located, and the name of the project, which is that of the compiled file.

Here we have seen a small example of how easy and simple it is to create microservices with WSO2 using bleeding edge technologies and facilitating the deployment to the cloud.
