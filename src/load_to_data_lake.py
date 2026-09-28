import pandas as pd
from auth import blob_service_client

def raw_file_to_data_lake(data):
    data_df = pd.DataFrame(data)
    container_name = 'raw2'
    blob_name = '311_service_request_mk.csv'
    csv_file = data_df.to_csv(index=False).encode("utf-8")

    # Get a blob client from the service client
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)
    blob_client.upload_blob(csv_file, overwrite=True)

    print('file upload successfully')

    return None