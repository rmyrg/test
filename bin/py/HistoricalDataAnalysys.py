from bs4 import BeautifulSoup
import pandas as pd
import requests as rs
from time import sleep
import csv
from datetime import datetime

today = datetime.now().strftime('%Y%m%d')

def load_historical_data(coin):
    file = './historical_data/' + coin + '.csv'
    df = pd.read_csv(file)
    #print(df[0])

def main():
    load_historical_data('ripple')

if __name__ == '__main__':
    main()
