import os
from dotenv import load_dotenv
from azure.storage.blob import BlobServiceClient, ContainerClient


load_dotenv()

account_name = "amdaristorageuk01"
account_url = f"https://{account_name}.blob.core.windows.net"

account_key = os.getenv('ACCOUNT_KEY')
conn_string = os.getenv('CONN_STRING')

if not conn_string:
    raise ValueError("CONN_STRING environment variable is not set")


blob_service_client = BlobServiceClient(account_url=account_url, credential=account_key) 
blob_name = '311_service_request_mk.csv'
container = ContainerClient.from_connection_string(conn_str=conn_string, container_name='raw2')
blob_client = container.get_blob_client(blob=blob_name)