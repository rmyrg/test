from bs4 import BeautifulSoup
import pandas as pd
import requests as rs
from time import sleep
import csv
from datetime import datetime

today = datetime.now().strftime('%Y%m%d')

def get_historical_data(coin):
    url='https://coinmarketcap.com/currencies/' + coin + '/historical-data/?start=20130428&end=' + today
    res=rs.get(url)
    soup=BeautifulSoup(res.text,"html.parser")
    prices=soup.select("div#historical-data  tr.text-right")
    file = 'historical_data/' + coin + '.csv'
    f = open(file,'w')
    writer = csv.writer(f, lineterminator='\n')
    for item in prices:
        date=item.select("td")[0].string
        open_price=item.select("td")[1].string
        high=item.select("td")[2].string
        low=item.select("td")[3].string
        close=item.select("td")[4].string
        volume=item.select("td")[5].string
        marketcap=item.select("td")[6].string

        csvlist = []
        csvlist.append(date)
        csvlist.append(open_price)
        csvlist.append(high)
        csvlist.append(low)
        csvlist.append(close)
        csvlist.append(volume)
        csvlist.append(marketcap)

        print(date,open_price,high,low,close,volume,marketcap)
        writer.writerow(csvlist)
    f.close()
    sleep(5)

def main():
    coinlist = 'coin-list.txt'
    #df = pd.read_csv(coinlist)
    #for coin in df['coin']:
    with open(coinlist) as f:
        for line in f:
            print(line.rstrip('\r\n'))
            get_historical_data(line.rstrip('\r\n'))

if __name__ == '__main__':
    main()
