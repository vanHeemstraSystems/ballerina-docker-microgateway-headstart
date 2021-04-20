# 100 - How to deploy an API with Microgateway

To discuss this issue, on one hand, we will create an API to be deployed with Microgateway, and a backend service associated with the API, which will be developed and deployed using Ballerina. Since in this article we want to focus on simplicity in the creation and deployment of microservices, we will use as an example a very basic microservice without authentication that will let us create and obtain books via HTTP GET and POST.

Besides Ballerina and Microgateway, we will rely on other tools:

- Microgateway Toolkit, which will help us create the API.
- Docker, which we will use to deploy both the service and the Microgateway.

In order to do this, we will need to have Ballerina, Microgateway Toolkit and Docker properly installed on our machine.
