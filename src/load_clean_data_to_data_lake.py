from auth import blob_service_client
import pandas as pd

def clean_data_to_data_lake(dataframe):
    data = pd.DataFrame(dataframe)

    container_name = 'clean2'
    blob_name = '311_service_request.parquet'
    parquet_data = data.to_parquet(index=False) 

    blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)
    blob_client.upload_blob(parquet_data, overwrite=True)

    print(f'Data loaded to {container_name}')

    return None