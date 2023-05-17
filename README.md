# CityForcast+
This is a microservices based weather forecasting and natural disasters feeding all over the globe.
# How it works
The UI "flutter app" is communicating with 2 microservices, The first one responsible for the weather forcasting by fetching the information needed from api.openweathermap.org api and it's built in python/flask, The second one is responsible for fetching the natural disasters all over the world during the past 24 hours and it's built in C#/.NET webapi.
# Technologies
<li>
  Flutter
</li>
<li>
  .NET
</li>
<li>
  Flask
</li>

# How to use
Navigate to the Microservice1 directory and open a terminal and run the following command: ```python3 app.py```
<br>Make sure flask is installed. If it's not installed you can install it by running this command: ```pip install flask```
<br> Now the first microservice is running.
<br><br>
Navigate to the Microservice2 directory and open a terminal and run the following command: ```dotnet run```
<br>Make sure .NET 7 SDK is installed
<br> Now the second microservice is running.
<br><br>
Navigate to the city_forecast_plus directory and open a terminal and run the following command: ```flutter run```
<br>If you don't have a mobile emulator you can run it on desktop (Linux,Windows or MacOS) or Web (Chrome or edge)
<br>Make sure flutter SDK is installed.
<br> Now the app is running, you will be able to type a city name and get it's weather or go to the alerts page at which you will find the natural disasters feed.
