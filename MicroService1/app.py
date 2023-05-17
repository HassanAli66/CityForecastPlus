
from flask import Flask, request
import requests
import socket

def get_network_ip():
    ip = None
    try:
        # Create a socket object
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        # Connect to a remote server
        sock.connect(('8.8.8.8', 80))
        # Get the local IP address of the socket
        ip = sock.getsockname()[0]
        # Close the socket
        sock.close()
    except socket.error:
        pass
    return ip

app = Flask(__name__)

@app.route('/weather')
def weather():
    city = request.args.get('city')
    apiKey = '0981a53056535828bdc13e46f571d4a2'
    url = f'http://api.openweathermap.org/data/2.5/weather?q={city}&appid={apiKey}&units=metric'
    response = requests.get(url)
    print(response)
    return response.json()
if __name__ == '__main__':

    app.run(host=get_network_ip(), port=5000)

