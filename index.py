import json
import boto3
import random

dynamo_db = boto3.client("dynamodb")
letters="abcdefghijklmnopqrstuvwxyz"
api_gateway = boto3.client("apigatewaymanagementapi", endpoint_url="https://url-for-endpoint/production")
def lambda_handler(event, context):
    word_found = False
    number_of_items = 0
    while  not word_found: 
        random_letter = letters[random.randint(0,len(letters)-1)]
        print(f"Random letter: {random_letter}")
        response = dynamo_db.scan(TableName="words", 
                            ScanFilter={
                                'word': { 
                                    'AttributeValueList': [
                                        { "S": random_letter }
                                    ],
                                'ComparisonOperator': 'LT'
                                },
                            }
        )
        number_of_items = len(response['Items'])
        if number_of_items > 0:
            word_found = True
    random_word = response['Items'][random.randint(0,number_of_items-1)]['word']['S']
    connectionId = event["requestContext"]["connectionId"]
    response = api_gateway.post_to_connection(ConnectionId=connectionId,Data=json.dumps(random_word).encode('utf-8'))
    return {
        'statusCode': 200
        #'body': json.dumps(random_word)
    }

