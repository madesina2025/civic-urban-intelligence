import pandas as pd

def transform_data(dataframe):
    data_df = pd.DataFrame(dataframe)

    columns = data_df.columns

    print(columns)

    selected_columns = data_df[['Unique Key','Created Date','Agency', 'Agency Name', 'Complaint Type' ,'Descriptor', 'Location Type' , 'Incident Zip' , 'Incident Address' , 'Street Name' ,
    'Cross Street 1', 'Cross Street 2' , 'Address Type' , 'City' , 'Landmark' ,  'Facility Type' , 'Status' , 'Due Date' , 'Resolution Description' ,
    'Resolution Action Updated Date' , 'Vehicle Type' , 'Location']]

    selected_columns.columns = (selected_columns.columns.str.strip().str.lower().str.replace(" ", "_", regex=False))
    
    return selected_columns

    #print(selected_columns)