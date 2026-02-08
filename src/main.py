from api_connect import api_connect
from load_to_data_lake import raw_file_to_data_lake
# from extract_from_data_lake import get_data_from_data_lake
from extract_from_data_lake import get_data_from_data_lake
from transform_data import transform_data
from load_clean_data_to_data_lake import clean_data_to_data_lake
import pandas as pd


def main():
    data_response = api_connect()
    load_data = raw_file_to_data_lake(data_response)
    data = get_data_from_data_lake()
    transformed_data = transform_data(data)
    cleaned_data = clean_data_to_data_lake(transformed_data)
    clean_load_result = clean_data_to_data_lake(transformed_data)
    
    return None

if __name__ == "__main__":
    main()

    