# 400 - Developing the API with Microgateway

Just as with Ballerina in the previous step, Microgateway Toolkit will let us initialize the project and create a basic project structure. We can do this using the following command.

```$ micro-gw init bookAPI```

- api_definitions: folder where we will include YAML files, which contain the definition of our APIs.This project will have the following structure:

-- conf: folder that includes the Docker or Kubernetes configuration file.

-- extensions: folder with Microgateway functionality extensions.

-- interceptors: folder with Microgateway interceptors. Empty by default.

-- services: folder with predefined Microgateway services, such as those that allow us to obtain a token or revoke it, and work as a proxy of the Key Manager.

-- policies.yaml: folder with use policies, predefined by default.

The following step will be creating the ***API definition***. Microgateway is compatible with the OpenAPI 3.0 specification, so we will build an API that is based on it, containing the following information.

```
openapi: 3.0.0
info:
versión: 1.0.0
title: Book API
license:
name: Apache 2.0
url: http://www.apache.org/licenses/LICENSE-2.0.html
tags:
- name: book
description: book tag description
x-wso2-basePath: /bookAPI/v1
x-wso2-production-endpoints:
urls:
- http://dockerBookService:9091/bookService
paths:
"/book/{bookId}":
get:
tags:
- book
description: Returns a single book
operationId: getBookById
x-wso2-disable-security: true
parameters:
- name: bookId
in: path
description: ID of book to return
required: true
schema:
type: integer
format: int64
responses:
'200':
description: successful operation
'404':
description: Book not found
"/book":
post:
tags:
- book
description: create a book
operationId: createBook
consumes:
- "application/json"
parameters:
- in: "body"
name: "body"
description: "Book object"
required: true
x-wso2-disable-security: true
responses:
'201':
description: created
'400':
description: Invalid payload received
```

- x-wso2-basePath: OpenAPI extension that will let us inform Microgateway of the context of the URL associated with our API.As you can see, the code is quite self-explanatory. But let’s take a closer look at certain aspects:

-- x-wso2-production-endpoints: Extension to indicate the backend linked to our API.

-- x-wso2-disable-security: Extension to indicate that we do not want to enable any kind of security in the resource where we enter the properties.

Microgateway has these and many more extensions that can let us have a greater degree of control than what is offered by default by OpenAPI.

In order to add security to an API, Microgateway accepts OAuth2 tokens (default option), JWT tokes or Basic authentication. But for both JWT and OAuth2 tokens we will need to associate a third application that will provide us with these tokens, such as the WSO2 Identity Server itself.

Once our API has been created as a YAML file and stored in the ```api_definitions``` folder, we will start building the project by executing the following command from the folder that contains it.

```$ micro-gw build bookAPI```

As we can see, this command will compile the files in the Ballerina format. This is becasue Microgateway is also based on this technology to implement the APIs. Deploy the API with Docker.

