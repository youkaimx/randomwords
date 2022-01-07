# Random Words

## WARNING
The code is not yet finished. At this point in time, what is needed is:
- Create the correct mapping from the API endpoint to the lambda
- Modify the python source with the connection URL grabbed from the stage created via the api gateway module. This may be done via a template
 
## Description
You will be creating a websocket-based API in AWS API Gateway. Please
create a working codeset: 
1. Client: You can use the client of your choice. Consider
using wscat. 
2. Server
- Configure an AWS API gateway endpoint which maintains a
WebSocket to the client
- A Lambda connected to the API gateway endpoint which
responds to requests sent to the API gateway
- A DynamoDB collection which contains a set of random
words eg [{ “word”: “car“}, {“word“: “truck“}, {“word“:
“banana“}] 
3. Simple workflow 
- Client should establish a WebSocket connection to the API
Gateway 
- Client should send a message to the API Gateway endpoint
that triggers the Lambda to read a random word out of the
DynamoDB collection 
- The Lambda should return the random word to the API
Gateway which should return it to the client which should
display it on the screen