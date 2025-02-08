# Life cycle

Here is an overview of the journey of the request to the response.

1. A request is made to the server
1. An initial empty response is passed through global middlewares ([before route matching](/0.1.0/http/middleware#before-route-matching))
3. One of your route matched the request
2. The response passes through route middlewares ([before route rendering](/0.1.0/http/middleware.html#before-response-rendered))
3. The response passes to your route callback ([route rendering](/0.1.0/http/response))
4. The response passes through route middlewares ([after route rendering](/0.1.0/http/middleware.html#after-response-rendered))
5. The response passes through global middlewares ([after route matching](/0.1.0/http/middleware#after-route-matching))
6. The response is returned
