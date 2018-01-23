{
  "$schema" : "http://json-schema.org/draft-04/schema#",
  "title" : "Data processing status",
  "type" : "object",
  "minProperties": 1,
  "maxProperties": 1,
  "additionalProperties": false,
  "required" : [ "statusCode" ],
  "properties" : {
    "statusCode" : {
      "description": "Processing result",
      "type" : "string",
      "enum" : [ "OK", "NOMATCH", "SYSERR" ]
    }
  }
}