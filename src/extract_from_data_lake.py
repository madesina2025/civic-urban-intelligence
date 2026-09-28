from io import BytesIO
import pandas as pd

# from .auth import blob_client
from auth import blob_client

def get_data_from_data_lake():
    stream_downloader = blob_client.download_blob()
    stream = BytesIO()

    # read the data into the stream
    stream_downloader.readinto(stream)

    # move the stream pointer to the beginning
    stream.seek(0)

    #print(stream_downloader)

    csv_data = pd.read_csv(stream)
    #print(csv_data.head())

    return csv_data

#get_data_from_data_lake()