import pandas as pd
import csv
import re
import numpy as np

with open("SF_listing.csv","r", encoding="utf8") as fin:
    reader = csv.reader(fin)
    #readerList = [line for line in reader]
    readerList = list(reader)

print(readerList[1][39].strip("]").strip("[").split("\","))


def superhost(val):
    if val == "t":
        return 1
    else: 
        return 0

def lenAmen(val1):
    x = val1.strip("]").strip("[").split("\",")
    return len(x)


with open("neighDist.csv","r", encoding="utf8") as fin:
    reader = csv.reader(fin)
    readerList = [line for line in reader][1:]

neighbourhoods = {}
for i in readerList:
    neighbourhoods[i[0]] = float(i[1]);

def distance(val1):
    return neighbourhoods[val1]

#dates = pd.read_csv("Calendar.csv", delimiter = ",", index_col = 0)
#modes = dates.groupby(['listing_id'])['price'].agg(pd.Series.mode).to_frame()
#modes.to_csv("modesCalendar.csv", index = True)

listings = pd.read_csv("SF_listing.csv", delimiter = ",", index_col = 0)
cleaned =  listings[["host_is_superhost", "neighbourhood_cleansed", "accommodates", "bathrooms", "bedrooms", "amenities", "review_scores_rating", "host_identity_verified", "review_scores_communication", "number_of_reviews"]]
cleaned["host_is_superhost"] = cleaned.apply(lambda x : superhost(x["host_is_superhost"]), axis = 1)
cleaned["amenities_score"] = cleaned.apply(lambda x : lenAmen(x["amenities"]), axis = 1)
cleaned["nonpeak_price"] = modes["nonpeak_price"] 
cleaned["peak_price"] = modes["peak_price"]
cleaned["distance_city"] = cleaned.apply(lambda x : distance(x["neighbourhood_cleansed"]), axis = 1)
cleaned["host_identity_verified"] = cleaned.apply(lambda x : superhost(x["host_identity_verified"]), axis = 1)

row_count=len(cleaned.index)

cleaned["price"] = ""
cleaned["peak"] = ""

for i in range(row_count):
    if i%2 == 0:
        cleaned.iloc[i,14] = cleaned.iloc[i,11]
        cleaned.iloc[i,15] = 0
    else:
        cleaned.iloc[i,14] = cleaned.iloc[i,12]
        cleaned.iloc[i,15] = 1
    

cleaned.replace('', np.nan, inplace=True)
cleaned.dropna(inplace = True)

cleaned.drop(["neighbourhood_cleansed", "amenities", "nonpeak_price", "peak_price"], axis = 1, inplace = True)

modes.to_csv("modesCalendar.csv", index = True)