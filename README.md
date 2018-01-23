
# taa-api-mock
Mock of Develop the Profession API created using AWS Api Gateway, AWS Lambda and Terraform.

# [Software Development Quality Assurance Policy](docs/NodejsDevQuality.md)

# Test data
To simulate all possible responses we deliver a few predefined forename prefixes which can be used to trigger proper Http code.

|Forename|Http code|Description|
|-|-|-|
|success|200|It mimics properly processed request|
|dataError|422|It mimics data error. It is supporting NOMATCH or SYSERR. To select behavior add the StatusCode to the forename as a suffix.|
|serverError|503|It mimics service unavailable. Empty body will be returned.|

If not listed above forename will be send then message "Internal server error - Incorrect test data" with 500 http code will be returned. 

# Data
The structure of the data is expected to be text in JSON format. The data will contain the following mandatory fields:
### Header
|Name|Description|
|-|-|
|organisation|The source of the data. [ABC, IMI or C&G ]|
|date|The date the data feed was created in YYYY-MM-DD format|
### Test Result
|Name|Description|
|-|-|
|forename|The testers forename|
|surname|The testers surname|
|email|Preferably the email address used for the MOT testing service|
|testDate|The date the assessment was completed YYYY-MM-DD format|
|certificateNo|The number of the issued certificate|
|year|YYYY/YYYY e.g. 2017/2018|
|score|Percentage score|
|pass|true or false|
|categoryGroup|A or B|
|dvsaId|Id used to access the MOT system|
|dob|YYYY-MM-DD|


Example JSON input document
```json
{
   "organisation":"ABC",
   "date":"2017-11-18",
   "testResult":{
      "forename":"Fred",
      "surname":"Blogs",
      "email":"fred.bloggs@teststation.co.uk",
      "testDate":"2017-11-07",
      "certificateNo":"1234567891",
      "year":"2017/2018",
      "score":"80",
      "pass":true,
      "categoryGroup":"B",
      "dvsaId":"BLOG1234",
      "dob":"1985-09-05"
   }
}
```

# Security
The API will be secured by an API key. Each Awarding body will have their own API key which will also have an attached Usage Plan that will throttle requests to a max of 5 per second with a daily quota of 1000 requests. The API key should be sent in an x-api-key header with each request.

# Design
A RESTful API will be provided to allow the Awarding Bodies to send the results of an assessment test. It is expected that the test results will be sent as soon as possible but sending all available test results in a series of posts once a day will be acceptable.

# Failure handling
If the service is unavailable for any reason an HTTP 503 Service Unavailable response code will be returned.
If usage plan throttling or quota limit is exceed then HTTP 429 Too Many Requests response code will be returned.

### Status Codes
|StatusCode|Description|
|-|-|
|OK|Record processed successfully.|
|NOMATCH|Corresponding record could not be found.|
|SYSERR|System error.|

### Example JSON Failure Code

```json
{
   "statusCode":"NOMATCH"
}
```