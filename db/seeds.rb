# trips
trip_names = ['Spring Break', 'Best Trip Eva', 'Iceland', 'Cross-Country Roadtrip', 'Weekend Getaway', 'Camping', 'Memorial Day Extravaganza']
trip_names.each do |t|
  description = Faker::Hipster.paragraph
  duration = Faker::Number.between(3, 20)
  Trip.create(name: t, description: description, duration: duration)
end

# fei's account
fei = User.create(firstname: 'Fei', lastname: 'Hafferkamp', email: Faker::Internet.email, dob: Faker::Date.birthday(25, 27), hometown: 'Omaha', username: 'fei', password: '123')
fei_trips = Trip.all.sample(5)
fei_trips.each do |trip|
  start_date = Faker::Date.forward(rand(15..60))
  UserTrip.create(ratings: Faker::Number.between(0, 5), start_date: start_date, end_date: start_date + trip.duration, travel_age: start_date.year - fei.dob.year, user_id: fei.id, trip_id: trip.id)
end

# friends' accounts
jim = User.create(firstname: 'Jim', lastname: 'Halpert', email: Faker::Internet.email, dob: Faker::Date.birthday(30, 35), hometown: 'Scranton', username: 'jim', password: '123')
Trip.all.sample(3).each do |trip|
  start_date = Faker::Date.forward(rand(15..60))
  UserTrip.create(ratings: Faker::Number.between(0, 5), start_date: start_date, end_date: start_date + trip.duration, travel_age: start_date.year - jim.dob.year, user_id: jim.id, trip_id: trip.id)
end

mscott = User.create(firstname: 'Michael', lastname: 'Scott ', email: Faker::Internet.email, dob: Faker::Date.birthday(40, 45), hometown: 'Scranton', username: 'mscott', password: '123')
Trip.all.sample(2).each do |trip|
  start_date = Faker::Date.forward(rand(15..60))
  UserTrip.create(ratings: Faker::Number.between(0, 5), start_date: start_date, end_date: start_date + trip.duration, travel_age: start_date.year - mscott.dob.year, user_id: mscott.id, trip_id: trip.id)
end

ron = User.create(firstname: 'Ron', lastname: 'Swanson', email: Faker::Internet.email, dob: Faker::Date.birthday(40, 45), hometown: 'Pawnee', username: 'ron', password: '123')
Trip.all.sample(3).each do |trip|
  start_date = Faker::Date.forward(rand(15..60))
  UserTrip.create(ratings: Faker::Number.between(0, 5), start_date: start_date, end_date: start_date + trip.duration, travel_age: start_date.year - ron.dob.year, user_id: ron.id, trip_id: trip.id)
end

tam = User.create(firstname: 'Tammy', lastname: 'I', email: Faker::Internet.email, dob: Faker::Date.birthday(40, 45), hometown: 'Pawnee', username: 'tam', password: '123')
Trip.all.sample(2).each do |trip|
  start_date = Faker::Date.forward(rand(15..60))
  UserTrip.create(ratings: Faker::Number.between(0, 5), start_date: start_date, end_date: start_date + trip.duration, travel_age: start_date.year - tam.dob.year, user_id: tam.id, trip_id: trip.id)
end

bob = User.create(firstname: 'Bob', lastname: 'Loblaw', email: Faker::Internet.email, dob: Faker::Date.birthday(40, 50), hometown: 'Somewhere', username: 'bob', password: '123')
Trip.all.sample(1).each do |trip|
  start_date = Faker::Date.forward(rand(15..60))
  UserTrip.create(ratings: Faker::Number.between(0, 5), start_date: start_date, end_date: start_date + trip.duration, travel_age: start_date.year - bob.dob.year, user_id: bob.id, trip_id: trip.id)
end

# random users
demo = User.create(firstname: 'De', lastname: 'Mo', email: Faker::Internet.email, dob: Faker::Date.birthday(40, 50), hometown: 'Somewhere', username: 'demo', password: '123')
Trip.all.sample(5).each do |trip|
  start_date = Faker::Date.forward(rand(15..60))
  UserTrip.create(ratings: Faker::Number.between(0, 5), start_date: start_date, end_date: start_date + trip.duration, travel_age: start_date.year - demo.dob.year, user_id: demo.id, trip_id: trip.id)
end

5.times do
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  email = Faker::Internet.email
  dob = Faker::Date.birthday(18, 80)
  hometown = Faker::Address.city
  username = Faker::Twitter.screen_name
  password = Faker::Music.instrument
  User.create(firstname: firstname, lastname: lastname, email: email, dob: dob, hometown: hometown, username: username, password: password)
end

#add user photos
User.all.each do |u|
  u.photo = Faker::Avatar.image
  u.save
end

# friendships
Friendship.create(user_id: fei.id, friend_id: jim.id, accepted: true)
Friendship.create(user_id: fei.id, friend_id: mscott.id, accepted: true)
Friendship.create(user_id: fei.id, friend_id: demo.id, accepted: true)
Friendship.create(user_id: fei.id, friend_id: bob.id, accepted: false)
Friendship.create(user_id: fei.id, friend_id: ron.id, accepted: false)

# messages
2.times do
  Message.create(sender_id: fei.id, receiver_id: ron.id, content: Faker::ChuckNorris.fact)
  Message.create(sender_id: ron.id, receiver_id: fei.id, content: Faker::VForVendetta.quote)
  Message.create(sender_id: fei.id, receiver_id: bob.id, content: Faker::ChuckNorris.fact)
  Message.create(sender_id: bob.id, receiver_id: fei.id, content: Faker::HarryPotter.quote)
  Message.create(sender_id: jim.id, receiver_id: fei.id, content: Faker::Movie.quote)
  Message.create(sender_id: mscott.id, receiver_id: fei.id, content: Faker::Dessert.topping)
  Message.create(sender_id: fei.id, receiver_id: demo.id, content: Faker::ChuckNorris.fact)
  Message.create(sender_id: demo.id, receiver_id: fei.id, content: Faker::Hipster.sentence)
  Message.create(sender_id: mscott.id, receiver_id: demo.id, content: Faker::Dessert.topping)
end

# user_trips
Trip.all.each do |trip|
  user = User.all.sample
  ratings = Faker::Number.between(0, 5)
  start_date = Faker::Date.forward(rand(15..60))
  end_date = start_date + trip.duration
  travel_age = start_date.year - user.dob.year
  UserTrip.create(ratings: ratings, start_date: start_date, end_date: end_date, travel_age: travel_age, user_id: user.id, trip_id: trip.id)
end

# destinations
15.times do
  name = Faker::HarryPotter.location
  description = Faker::Hipster.paragraphs(1)
  lat = Faker::Address.latitude
  lng = Faker::Address.longitude
  Destination.create(name: name, description: description, lat: lat, lng: lng)
end

# trip_destinations
UserTrip.all.each do |user_trip|
  trip = user_trip.trip
  destination = Destination.all.sample
  arrival = user_trip.start_date + rand(0..trip.duration)
  departure = arrival + rand(0..7)
  TripDestination.create(trip_id: trip.id, destination_id: destination.id, arrival: arrival, departure: departure)
end

# activities
2.times do
  TripDestination.all.each do |td|
    name = Faker::Coffee.blend_name
    description = Faker::Coffee.notes #=> "balanced, silky, marzipan, orange-creamsicle, bergamot"
    cost = Faker::Number.decimal(2)
    start_time = td.arrival + 1.hour
    end_time = start_time + 2.hour
    address = Faker::Address.street_address + ', ' + Faker::Address.city + ', ' + Faker::Address.state_abbr + ' ' + Faker::Address.zip
    lat = Faker::Address.latitude
    lng = Faker::Address.longitude
    Activity.create(name: name, description: description, cost: cost, start_time: start_time, end_time: end_time, address: address, lat: lat, lng: lng, trip_destination_id: td.id)
  end
end
