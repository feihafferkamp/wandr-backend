# users
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

# trips
15.times do
  name = Faker::Hipster.word
  description = Faker::Hipster.paragraph
  duration = Faker::Number.between(3, 20)
  Trip.create(name: name, description: description, duration: duration)
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
  description = Faker::HarryPotter.quote
  lat = Faker::Address.latitude
  lng = Faker::Address.longitude
  Destination.create(name: name, description: description, lat: lat, lng: lng)
end

# trip_destinations
3.times do
  UserTrip.all.each do |user_trip|
    trip = user_trip.trip
    destination = Destination.all.sample
    arrival = user_trip.start_date + rand(0..trip.duration)
    departure = arrival + rand(0..7)
    TripDestination.create(trip_id: trip.id, destination_id: destination.id, arrival: arrival, departure: departure)
  end
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

# fei's account
fei = User.create(firstname: 'Fei', lastname: 'Hafferkamp', email: Faker::Internet.email, dob: Faker::Date.birthday(25, 27), hometown: 'Omaha', username: 'fei', password: '123')
fei_trips = Trip.all.sample(5)
fei_trips.each do |trip|
  start_date = Faker::Date.forward(rand(15..60))
  UserTrip.create(ratings: Faker::Number.between(0, 5), start_date: start_date, end_date: start_date + trip.duration, travel_age: start_date.year - fei.dob.year, user_id: fei.id, trip_id: trip.id)
end

# friend's account
jon = User.create(firstname: 'Jonathan', lastname: 'Hafferkamp', email: Faker::Internet.email, dob: Faker::Date.birthday(25, 27), hometown: 'Spokane', username: 'jon', password: '123')
jon_trips = Trip.all.sample(5)
jon_trips.each do |trip|
  start_date = Faker::Date.forward(rand(15..60))
  UserTrip.create(ratings: Faker::Number.between(0, 5), start_date: start_date, end_date: start_date + trip.duration, travel_age: start_date.year - jon.dob.year, user_id: jon.id, trip_id: trip.id)
end
