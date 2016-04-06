# Status

Overly complex status app that get's updated via a simple POST.

# API

## Retrieving the Current Status

The API supports both JSON and text responses:

JSON:

    curl http://current_status.dev/api/v1/current_status.json
    
    {
      "current_status": "down",
      "recent_messages": [
        {
          "content": "This message might explain why we are down",
          "created_at": "2016-04-06T19:34:35.217Z"
        },
        ...
      ]
    }
    
text:

    curl http://current_status.dev/api/v1/current_status

    Current Status: down
    Recent Messages:
    April 6, 2016 7:34pm UTC - This message might explain why we are down
    ....

## Updating the Current Status

There are only two values: `status` and `message`. Both are optional.

`status` may be either `up` or `down`

`message` is a text status message.

Here are some cURL examples for updating the status.

The supported parameters are `status` and `message`. Both are optional.

    # Updating the status and the message together
    curl --data "status=down&message=Message%20About%20Status" http://current_status.dev/api/v1/current_status
    
    # Just updating the message
    curl --data "message=Message%20About%20Status" http://current_status.dev/api/v1/current_status
    
    # Just updating the status
    curl --data "status=up" http://current_status.dev/api/v1/current_status


JSON is supported too. If you use the `/status.json` endpoint you will receive a JSON response including the current status and recent messages.
    
    curl -H "Content-Type: application/json" -X POST -d '{"status":"up","message":"fiz bam"}' http://current_status.dev/api/v1/current_status.json
    
    curl -H "Content-Type: application/json" -X POST -d '{"status":"down"}' http://current_status.dev/api/v1/current_status.json
    
    curl -H "Content-Type: application/json" -X POST -d '{"message":"Lorem ipsum dolor sit amet"}' http://current_status.dev/api/v1/current_status.json
    

The response is identical to retrieving the status (see "Retrieving the Current Status" above) except in the case of errors (see "Errors" below)


## Errors

If you provide invalid data when updating the status, you will get a non 2xx status code response. If using the JSON endpoint an error message will also be provided in the `error` key. The current status and recent messages will still be returned.

Example:

    curl -H "Content-Type: application/json" -X POST -d '{"status":"foobar"}' http://current_status.dev/api/v1/current_status.json
    
    # Response:
    {
      "current_status": "up",
      "recent_messages": [
        {
          "content": "fiz bam",
          "created_at": "2016-04-05T18:30:57.040Z"
        },
        ...
      ],
      "error": "Invalid Status"
    }
    
    
If not using JSON, the response will include the error in the text output:

Example:

    curl --data "status=upers&message=Message%20About%20Status" http://current_status.dev/api/v1/current_status
    
    Error: Invalid Status
    Current Status: up
    Recent Messages:
    April 6, 2016 7:41pm UTC - Message About Status
    ...
    
# Testing

Run tests with `rake test`