#set($payload = $util.parseJson($input.path('$.errorMessage')))
{
    #if($payload.personName.contains("NOMATCH"))
        "statusCode": "NOMATCH"
    #else
        "statusCode": "SYSERR"
    #end
}