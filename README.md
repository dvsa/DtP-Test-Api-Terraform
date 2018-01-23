
# taa-api-mock
Mock of Develop the Profession API created using AWS Api Gateway, AWS Lambda and Terraform.

# [Software Development Quality Assurance Policy](docs/NodejsDevQuality.md)

# Test data
To simulate all possible responses we deliver few predefined forename prefixes which can be used to trigger proper Http code.
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
A RESTful API will be provided to allow the Awarding Bodies to send the results of an assessment test. It is expected that the test results will be sent as soon as possible but sending all available test results in a series of posts once a day will be acceptable. A process will read the data and attempt to match the test result records with the testers MOT account using the dvsaId and their date of birth. If a matching user record is found in the MOT database the test results will be updated and linked to the testers user account and an HTTP 200 OK response code will be returned. If there is no match for the userId and dob in the database the record will be rejected, and an HTTP 422 Unprocessable Entity response code will be returned along with a StatusCode describing the cause of the failure as detailed below.

The API call may contain both new records and corrections to previous records (whether they were previously processed correctly or not) and the process will handle both inserts and updates to the test result data in the MOT db.

An additional process will also be required to disable the user accounts of all users that have not passed their assessment tests by the cut off date. This will only require one execution per year so could be manually invoked.

# Failure handling
If there is no match for the userId and dob in the database the record will be rejected. When the data has been corrected at source it should be sent again as usual in a subsequent API call and will be processed as normal. If the data is thought to be incorrect within the DVSA system (incorrect dob) then the data should be corrected by the tester in MTS and the results resubmitted again. It is accepted that this may result in the same record being rejected multiple times until the data (dob) is corrected.

If the service is unavailable for any reason an HTTP 503 Service Unavailable response code will be returned.
If usage plan throttling or quota limit is exceed then HTTP 429 Too Many Requests response code will be returned.

### Status Codes
|StatusCode|Description|
|-|-|
|OK|Record processed successfully.|
|NOMATCH|The dvsaId and the dob did not match a record, one or the other is incorrect. Or could not find a record matching the dvsaId|
|SYSERR|System error.|

### Example JSON Failure Code

```json
{
   "statusCode":"NOMATCH"
}
```