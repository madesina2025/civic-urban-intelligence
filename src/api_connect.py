import requests
import csv



# def api_connect():
#     api_response = requests.get('http://data.cityofnewyork.us/resource/erm2-nwe9.json')
#     api_response.raise_for_status
#     return api_response.json()

# print(api_connect())

def api_connect():
    data_list = []
    # project_root = Path(__file__).resolve().parents[1]
    # csv_path = project_root / "311_Service_Requests_from_2010_to_Present_20251214.csv"
    with open("../311_Service_Requests_from_2010_to_Present_20251214.csv", mode='r', encoding='utf-8') as data:
        csv_reader = csv.DictReader(data)
        data_list = [row for row in csv_reader]
        return data_list
        # print([data_list[:2]])

# print(api_connect())