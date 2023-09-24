# Whether, Sweater? API
![Tests](https://badgen.net/badge/tests/passing/green?icon=github)
![Commits](https://badgen.net/github/last-commit/DavisWeimer/market_money?icon=github)

Whether, Sweater? API is built to expose endpoints for a Frontend app looking to:
- Get data about weather in a requested City
- Create, Authenticate, and Generate unique API Keys for it's Users
- Create Road Trips for it's Users

## Ruby/Rails version<br>
`Ruby 3.2.2`<br>
`Rails 7.0.7.2`

## Built with<br>
![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
![Postman Badge](https://img.shields.io/badge/Postman-FF6C37?logo=postman&logoColor=fff&style=for-the-badge)

Getting Started
-------------
To get a local copy, follow these steps

### <b>Installation</b>

1. Fork the Project
2. Clone the repo (SSH) 
```shell 
git@github.com:DavisWeimer/whether_sweater_api.git 
```
3. Install the gems
```ruby
bundle install
```
4. Create the database
```ruby
rails db:{drop,create,migrate,seed}
```
5. Run the server
```ruby
rails s
```
6. Test the endpoints at this local URL:
```bash
http://localhost:3000/
```
### <b>Endpoints Available</b>
1. Get weather for a city
Request:
```ruby
GET /api/v0/forecast?location=cincinatti,oh
Content-Type: application/json
Accept: application/json
```
Response:
```json
{
    "data": {
        "id": "null",
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "last_updated": "2023-09-24 12:00",
                "temperature": 62.6,
               <etc...>
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
2. Get One Market
```ruby
GET /api/v0/markets/:id
```
3. Get All Vendors for a Market
```ruby
GET /api/v0/markets/:id/vendors
```
4. Get One Vendor
```ruby
GET /api/v0/vendors/:id
```
5. Create a Vendor
```ruby
POST /api/v0/vendors
```
