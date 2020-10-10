from bs4 import BeautifulSoup
import pandas as pd
import requests as rs
import csv
from datetime import datetime

def get_historical_data():
    url='https://coinmarketcap.com/all/views/all/'
    res=rs.get(url)
    soup=BeautifulSoup(res.text,"html.parser")
    file = 'coin-list.txt'
    f = open(file,'w')
    for a in soup.find_all("a", class_="currency-name-container link-secondary"):
        coin = a.get('href').replace('currencies','').replace('/','')
        f.write(coin + '\n')
    f.close()
    for a in soup.find_all("td", class_="text-left col-symbol"):
        symbol = a.string
        print(symbol)

def main():
    get_historical_data()

if __name__ == '__main__':
    main()
