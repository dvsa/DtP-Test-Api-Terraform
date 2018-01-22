#set($payload = $util.parseJson($input.path('$.errorMessage')))
{
    #if($payload.personName.contains("NODVSAID"))
        "statusCode": "NODVSAID"
    #elseif($payload.personName.contains("NOMATCH"))
        "statusCode": "NOMATCH"
    #else
        "statusCode": "SYSERR"
    #end
}