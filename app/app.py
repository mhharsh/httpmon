import requests

from prometheus_client import start_http_server, Summary
import random
import time
from prometheus_client import generate_latest, Gauge, Summary

URL_UP = Gauge('sample_external_url_up', 'Checks up or not', ('url',))

URL_RESPONSE = Summary(
    'sample_external_url_response_ms', 
    'The request latency in seconds.',
    ('url',)
    )

def generate_metrics(url):
    resp = requests.get(url)
    URL_UP.labels(url=url).set(1 if resp.status_code == 200 else 0)
    URL_RESPONSE.labels(url=url).observe(resp.elapsed.total_seconds() / 1000)
   
if __name__ == '__main__':
    start_http_server(8000)
    while True:
        url1 = 'https://httpstat.us/503'
        generate_metrics(url1)
        url2 = 'https://httpstat.us/200'
        generate_metrics(url2)
