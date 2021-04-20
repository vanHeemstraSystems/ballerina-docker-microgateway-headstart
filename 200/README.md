# 200 - Developing the service with Ballerina and Microgateway

The service project will have a very simple structure. It will be composed of the root folder, bookService, and the module with our source code, http. In order to initialize the project, we will have to execute the following command from the main folder.

```$ bal init```

Our service will be called ***HTTPService.bal*** and will look as follows:

```
import ballerina/http;
import ballerina/log;
import ballerinax/docker;

@docker:Expose {}
listener http:Listener bookEP = new(9091);
map<json> booksMap = {};

@docker:Config {
  Registry:"com.chakray.example", name:"example", tag:"v1.0"
}

@http:ServiceConfig {
  basePath: "/bookService"
}

service books on bookEP {
  @http:ResourceConfig {
    methods: ["GET"], path: "/book/{bookId}"
  }

  resource function getById(http:Caller caller, http:Request req, string bookId) {
    json? payload = booksMap[bookId];
    http:Response response = new;
    if (payload == null) {
      response.statusCode = 404;
      payload = "Item Not Found";
    }
    response.setJsonPayload(untaint payload);
    var result = caller->respond(response);
    if (result is error) {
      log:printError("Error sending response", err = result);
    }
  }@http:ResourceConfig {
    methods: ["POST"], path: "/book"
  }

  resource function addBook(http:Caller caller, http:Request req) {
    http:Response response = new;
    var bookReq = req.getJsonPayload();
    if (bookReq is json) {
      string bookId = bookReq.book.id.toString();
      booksMap[bookId] = bookReq;
      response.statusCode = 201;
      response.setHeader("Location", "http://localhost:9091/bookService/book/" + bookId);
    } else {
      response.statusCode = 400;
      response.setPayload("Invalid payload received");
    }
    var result = caller->respond(response);
    if (result is error) {
      log:printError("Error sending response", err = result);
    }
  }
}
```
HTTPService.bal

We import the Ballerina utility libraries: docker, http and log.Using this code as a reference, let’s focus on the key parts of this service:

- We configure our service to listen to the requests arriving at port 9091 within the context of the /bookService URL.

- We link two resources to the service: one that listens for the GET method which expects an identifier in the URL, and another one that listens for the POST method, which expects a JSON object as a message.

- The GET method will return response code 200 and the object associated with the identifier posted in the URL, or 404 if the object is not found.

- The POST method will store the JSON object in a map in the internal memory and respond 201 and a header containing the URL of our service if we want to retrieve the stored book.


