{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title" : "Annual Assessment test result data structure",
  "type": "object",
  "minProperties": 3,
  "maxProperties": 3,
  "additionalProperties": false,
  "properties": {
    "organisation": {
      "type": "string",
      "description": "The source of the data. [ABC, IMI or C&G ]"
    },
    "date": {
      "type": "string",
      "description": "The date the data feed was created in YYYY-MM-DD format"
    },
    "testResult": {
      "type": "object",
      "minProperties": 11,
      "maxProperties": 11,
      "additionalProperties": false,
      "properties": {
        "forename": {
          "type": "string",
          "description": "The testers forename"
        },
        "surname": {
          "type": "string",
          "description": "The testers surname"
        },
        "email": {
          "type": "string",
          "description": "preferably the email address used for the MOT testing service"
        },
        "testDate": {
          "type": "string",
          "description": "The date the assessment was completed YYYY-MM-DD format"
        },
        "certificateNo": {
          "type": "string",
          "description": "The number of the issued certificate"
        },
        "year": {
          "type": "string",
          "description": "YYYY/YYYY e.g. 2017/2018"
        },
        "score": {
          "type": "string",
          "description": "Percentage score"
        },
        "pass": {
          "type": "boolean",
          "description": "true or false"
        },
        "categoryGroup": {
          "type": "string",
          "description": "A or B"
        },
        "dvsaId": {
          "type": "string",
          "description": "Id used to access the MOT system"
        },
        "dob": {
          "type": "string",
          "description": "Date of birth in format YYYY-MM-DD"
        }
      },
      "required": [
        "forename",
        "surname",
        "email",
        "testDate",
        "certificateNo",
        "year",
        "score",
        "pass",
        "categoryGroup",
        "dvsaId",
        "dob"
      ]
    }
  },
  "required": [
    "organisation",
    "date"
  ]
}