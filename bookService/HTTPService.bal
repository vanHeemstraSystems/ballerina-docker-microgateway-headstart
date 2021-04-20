import ballerina/log;
import ballerina/http;
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
