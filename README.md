# README

This is a Ruby on Rails API application that allows for simple booking.

* Database creation
rails db:setup

* Running
rails server

* Examples of requests (httpie formatted)

  http GET :3000/rentals api_token="j6hd9@l664HDv2agh"

  http POST :3000/rentals api_token="j6hd9@l664HDv2agh" name="Villa Renoma" daily_rate=820

  http GET :3000/rentals/1/bookings api_token="j6hd9@l664HDv2agh"

  http POST :3000/rentals/1/bookings api_token="j6hd9@l664HDv2agh" start_at="2017-04-19" end_at="2017-04-27" client_email="myemail@client.pl" price=10000
