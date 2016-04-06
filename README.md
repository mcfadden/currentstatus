# Status

Overly simple status app that get's updated via a simple POST.

# Updating The Status

There are only two values: `status` and `message`. Both are optional.

`status` may be either `up` or `down`

`message` is a text status message.

Here are some cURL examples for updating the status.

The supported parameters are `status` and `message`. Both are optional.

    # Updating the status and the message together
    curl --data "status=down&message=Message%20About%20Status" http://currentstatus.dev
    
    # Just updating the message
    curl --data "message=Message%20About%20Status" http://currentstatus.dev
    
    # Just updating the status
    curl --data "status=up" http://currentstatus.dev


JSON is supported too. If you use the `/status.json` endpoint you will receive a JSON response including the current status and recent messages.
    
    curl -H "Content-Type: application/json" -X POST -d '{"status":"up","message":"fiz bam"}' http://currentstatus.dev/status.json
    
    curl -H "Content-Type: application/json" -X POST -d '{"status":"down"}' http://currentstatus.dev/status.json
    
    curl -H "Content-Type: application/json" -X POST -d '{"message":"Lorem ipsum dolor sit amet"}' http://currentstatus.dev/status.json
    
You may also GET `/status.json` and you will receive the current status and recent messages in JSON format.

### Errors

If you post invalid data, you will get a non 200 status code response. If using the JSON endpoint an array of errors will be present in the `errors` key in the response.

Example:

    curl -H "Content-Type: application/json" -X POST -d '{"status":"foobar"}' http://currentstatus.dev/status.json
    
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
      "errors": [
        "Invalid Status"
      ]
    }
    
    
    
# Testing

Run tests with `rake test`