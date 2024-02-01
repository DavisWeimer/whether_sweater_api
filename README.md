<div align='center'>
  <img src="https://github.com/DavisWeimer/whether-sweater-fe/assets/128326999/be371417-729a-4f97-a5ba-72a6e43a0344" style="width: 400px" />

  ![GitHub last commit](https://img.shields.io/github/last-commit/DavisWeimer/whether_sweater_api?style=plastic)
  ![Gem Version](https://img.shields.io/gem/v/rails?style=plastic&label=rails)
  ![Static Badge](https://img.shields.io/badge/tests-passing-green?style=plastic&color=4CBB17)

  #### Let's Connect!
  <a target="_blank" href="https://www.linkedin.com/in/davis-weimer/" rel="noopener noreferrer"><img src="https://img.shields.io/badge/-LinkedIn-303030?style=for-the-badge&logo=Linkedin&logoColor=00C6BA"></img></a>
  <a target="_blank" href="mailto:davisweimer@gmail.com" rel="noopener noreferrer"><img src="https://img.shields.io/badge/-Gmail-303030?style=for-the-badge&logo=Gmail&logoColor=00C6BA"></img></a>
  <a target="_blank" href="https://www.dw-portfolio.com/" rel="noopener noreferrer"><img src="https://img.shields.io/badge/-Portfolio-303030?style=for-the-badge&logo=Vercel&logoColor=00C6BA"></img></a>
</div>

<h1 id="introduction">Introduction</h1>
The Whether, Sweater? Rails API provides seamless access to city weather forecasts and supports robust JWT-based user authentication, enabling personalized road trip planning in a single, cohesive platform.

# Features
- **User Authentication**: Secure registration, login/logout functionality using JWT sessions.
- **Weather Forecasting**: Select a city to view its current weather and upcoming forecast.
- **Road Trip Planning**: Input your trip details to receive estimated travel times and weather conditions upon arrival.

# Built with<br>
<img src="https://skillicons.dev/icons?i=rails,ruby,postgres,vscode,postman" alt="My languages"/>

# Table of Contents
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Endpoints Available](#endpoints-available)
  - [1. User Registration Trip](#1-user-registration-trip)
  - [2. User Login Trip](#2-user-login-trip)
  - [3. User Logout Trip](#3-user-logout-trip)
  - [4. Get Weather for a City](#4-get-weather-for-a-city)
  - [5. Create a Road Trip](#5-create-a-road-trip)
  - [6. Get Photo of City](#6-get-photo-of-city)
- [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)
- [Check the deployment out here](#check-the-deployment-out-here)

<h1 id="getting-started">Getting Started</h1>

To get a local copy up and running, git clone and follow these steps.

1. Install the gems
```ruby
bundle install
```
2. Create the database
```ruby
rails db:{drop,create,migrate,seed}
```

<h1 id="configuration">Configuration</h1>

You will need to register and or obtain API keys from:
- The Weather API — https://www.weatherapi.com/
- The MapQuest API — https://developer.mapquest.com/documentation/
- The Unsplash API — https://unsplash.com/oauth/applications
##### *Note*: For the Unsplash API, you must register the app to acquire an `access key`.

Once you have acquired keys for all three API's, you are ready to encrypt them within the app
1. Run this command to create your `master.key` & open the Rails Credentials file
```bash
EDITOR="code --wait" rails credentials:edit
```
2. Copy this block in and fill in the corresponding fields with your keys (More info on Rails Credentials [here](https://web-crunch.com/posts/the-complete-guide-to-ruby-on-rails-encrypted-credentials))
```ruby
weather:
  key: < your Weather API key >

map_quest:
  key: < your MapQuest key >

unsplash:
  access_key: < your Unsplash Access key >
  secret_key: < your Unsplash Secret key >

```
3. Close the Rails Credentials file to encrypt and save them, you should see this output in your terminal:
```bash
File encrypted and saved.
```
5. Run the server
```ruby
rails s
```
5. Test the endpoints at this local URL and any of the endpoint URI's listed below:
```bash
http://localhost:3000/
```

<h1 id="endpoints-available">Endpoints Available</h1>

<div align='center'>  
  <h2 id="1-user-registration-trip">1. User Registration Trip</h2>
</div>

<table align="center">
<tr>
<th width="500px">
<small>✍️ Example Request</small>
</th>
<th width="500px">
<small>
📂 Required
</small>
</th>
</tr>
<tr>
<td>
  
```
POST /signup
Content-Type: application/json
Accept: application/json
```

</td>
<td>
  
`Body:`
  
```json
{
    "user": {
        "email": "test@test.com",
        "password": "password"
    }
}
```
</td>
</tr>
<tr>
<th colspan="2">
📦 <b>Example Response</b>
</th>
</tr>
<tr>
<td colspan="2">
<details>
<summary>
🟢 Status <code>200</code> : Successful Response
</summary>
<br>

`Body:`
  
```json
{
    "status": {
        "code": 200,
        "message": "Signed up sucessfully."
    },
    "data": {
        "id": 3,
        "email": "test@test.com",
        "created_at": "2024-01-31T17:08:07.655Z",
        "created_date": "01/31/2024"
    }
}
```
</details>
</td>
</tr>
</table>

<div align='center'>  
  <h2>2. User Login Trip</h2>
</div>

<table align="center">
<tr>
<th width="500px">
<small>✍️ Example Request</small>
</th>
<th width="500px">
<small>
📂 Required
</small>
</th>
</tr>
<tr>
<td>
  
```
POST /login
Content-Type: application/json
Accept: application/json
```

</td>
<td>

`Body:`

```json
{
    "user": {
        "email": "test@test.com",
        "password": "password"
    }
}
```
</td>
</tr>
<tr>
<th colspan="2">
📦 <b>Example Response</b>
</th>
</tr>
<tr>
<td colspan="2">
<details>
<summary>
🟢 Status <code>200</code> : Successful Response
</summary>
<br>
  
`Body:`

```json
{
    "status": {
        "code": 200,
        "message": "Logged in sucessfully."
    },
    "data": {
        "id": 2,
        "email": "test@test.com",
        "created_at": "2024-01-31T16:15:38.953Z",
        "created_date": "01/31/2024"
    }
}
```

`Headers:`

```json
{
  "Authorization": "Bearer eyJhbGciO..."
}
```
</details>
</td>
</tr>
</table>

<div align='center'>  
  <h2>3. User Logout Trip</h2>
</div>

<table align="center">
<tr>
<th width="500px">
<small>✍️ Example Request</small>
</th>
<th width="500px">
<small>
📂 Required
</small>
</th>
</tr>
<tr>
<td>
  
```
DELETE /logout
Content-Type: application/json
Accept: application/json
```

</td>
<td>

`Headers:`

```json
{
  "Authorization": "Bearer eyJhbGciO..."
}
```
</td>
</tr>
<tr>
<th colspan="2">
📦 <b>Example Response</b>
</th>
</tr>
<tr>
<td colspan="2">
<details>
<summary>
🟢 Status <code>200</code> : Successful Response
</summary>
<br>
  
`Body:`

```json
{
    "status": 200,
    "message": "Logged out successfully."
}
```
</details>
</td>
</tr>
</table>

<div align='center'>  
  <h2>4. Get Weather for a City</h2>
  <h4>⚠️ Requires Bearer Token</h4>
</div>

<table align="center">
<tr>
<th width="500px">
<small>✍️ Example Request</small>
</th>
<th width="500px">
<small>
📂 Required
</small>
</th>
</tr>
<tr>
<td>
  
```
GET /api/v0/forecast?location=Denver,CO
Content-Type: application/json
Accept: application/json
```

</td>
<td>

`Params:`
```json
{
  "location": "Denver, CO"
}
```

`Headers:`
  
```json
{
  "Authorization": "Bearer eyJhbGciO..."
}
```
</td>
</tr>
<tr>
<th colspan="2">
📦 <b>Example Response</b>
</th>
</tr>
<tr>
<td colspan="2">
<details>
<summary>
🟢 Status <code>200</code> : Successful Response
</summary>
<br>

`Body:`
  
```json
{
    "data": {
        "id": "null",
        "type": "forecast",
        "attributes": {
                "current_weather": {
                    "last_updated": "2023-09-24 12:00",
                    "temperature": 62.6,
                    etc
            },
            "daily_weather": [
                {
                    "date": "2023-09-24",
                    "sunrise": "06:49 AM",
                     etc
                },
                {...} etc
            ],
            "hourly_weather": [
                {
                    "time": "00:00",
                    "temperature": 62.4,
                    etc
                },
                {...} etc
            ]
            }
      }
}
```
</details>
</td>
</tr>
</table>

<div align='center'>  
  <h2>5. Create a Road Trip</h2>
  <h4>⚠️ Requires Bearer Token</h4>
</div>

<table align="center">
<tr>
<th width="500px">
<small>✍️ Example Request</small>
</th>
<th width="500px">
<small>
📂 Required
</small>
</th>
</tr>
<tr>
<td>
  
```
POST /api/v0/road_trip
Content-Type: application/json
Accept: application/json
```

</td>
<td>

`Headers:`
  
```json
{
  "Authorization": "Bearer eyJhbGciO..."
}
```

`Body:`

```json
{
  "origin": "Denver,CO",
  "destination": "Chicago,IL",
}
```
</td>
</tr>
<tr>
<th colspan="2">
📦 <b>Example Response</b>
</th>
</tr>
<tr>
<td colspan="2">
<details>
<summary>
🟢 Status <code>200</code> : Successful Response
</summary>
<br>

`Body:`
  
```json
{
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "Chicago,IL",
            "travel_time": "13 hrs 40 mins",
            "weather_at_eta": {
                "datetime": "2024-02-01 11:56",
                "condition": "Partly cloudy",
                "temperature": 48.0
            }
        }
    }
}
```
</details>
</td>
</tr>
</table>

<div align='center'>  
  <h2>6. Get Photo of City</h2>
  <h4>⚠️ Requires Bearer Token</h4>
</div>

<table align="center">
<tr>
<th width="500px">
<small>✍️ Example Request</small>
</th>
<th width="500px">
<small>
📂 Required
</small>
</th>
</tr>
<tr>
<td>
  
```
GET /api/v0/backgrounds?location=New+York+City,+NY
Content-Type: application/json
Accept: application/json
```

</td>
<td>

`Params:`
```json
{
  "location": "New York City, NY"
}
```

`Headers:`
  
```json
{
  "Authorization": "Bearer eyJhbGciO..."
}
```
</td>
</tr>
<tr>
<th colspan="2">
📦 <b>Example Response</b>
</th>
</tr>
<tr>
<td colspan="2">
<details>
<summary>
🟢 Status <code>200</code> : Successful Response
</summary>
<br>

`Body:`
  
```json
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "image": {
                "location": "New York City, NY",
                "image_url": "https://images.unsplash.com/photo-1633...",
                "credit": {
                    "source": "https://unsplash.com/photos/a-view-of-a-city...",
                    "author": "Gabo Romay",
                    "portfolio": null
                }
            }
        }
    }
}
```
</details>
</td>
</tr>
</table>

# Contributing
Contributions are what make the open-source community such an amazing place to create in. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

# Acknowledgements
- [Weather API](https://www.weatherapi.com/) - Weather data source.
- [Mapquest API](https://developer.mapquest.com/) - Location data source.
- [Unsplash API](https://unsplash.com/) - Photo source.
- [React Documentation](https://reactjs.org/) - For React resources and tutorials.


# Check the deployment out here:
#### https://whether-sweater-fe.vercel.app/
