import datetime
import multiprocessing
import os
import pandas as pd
import requests

CACHE = os.path.expanduser('~/.cache/spgpw/')
GPW_DATE_FORMAT = '%d-%m-%Y'
GPW_INSTRUMENT_TYPE = { 'Indeksy': 1, 'akcje': 10 }

def download_csv(date : datetime.date, type : int):
    if date.weekday() == 5 or date.weekday() == 6:
        return

    fmt_date = date.strftime(GPW_DATE_FORMAT)
    url = f'https://www.gpw.pl/archiwum-notowan?fetch=1&type={type}&instrument=&date={fmt_date}'
    file_name = f'{CACHE}{fmt_date}.csv'

    if os.path.exists(file_name):
        return

    r = requests.get(url)
    if r.status_code != 200:
        print(f'Failed to download data for {fmt_date}')
        return

    try:
        df = pd.read_excel(r.content, engine='xlrd')
        df.to_csv(file_name, index=False)
    except:
        print(f'Failed to parse data for {fmt_date}')

def cache(days : int) -> pd.DataFrame:
    if not os.path.exists(CACHE):
        os.makedirs(CACHE)
    dates = [datetime.date.today() - datetime.timedelta(days=x) for x in range(1, days + 1)]
    with multiprocessing.Pool() as p:
        # p.starmap(download_csv, [(date, GPW_INSTRUMENT_TYPE['Indeksy']) for date in dates])
        p.starmap(download_csv, [(date, GPW_INSTRUMENT_TYPE['akcje']) for date in dates])

    df_list = [
        pd.read_csv(f'{CACHE}{date.strftime(GPW_DATE_FORMAT)}.csv')
        for date in dates if os.path.exists(f'{CACHE}{date.strftime(GPW_DATE_FORMAT)}.csv')
    ]
    return pd.concat(df_list)


df : pd.DataFrame = cache(365 * 32)
df.to_csv('stock_data.csv', index=False)
