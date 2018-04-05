# users
3.times do
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  email = Faker::Internet.email
  dob = Faker::Date.birthday(18, 80)
  hometown = Faker::Address.city
  username = Faker::Twitter.screen_name
  password = Faker::Music.instrument
  User.create(firstname: firstname, lastname: lastname, email: email, dob: dob, hometown: hometown, username: username, password_digest: password)
end

# trips
5.times do
  name = Faker::Hipster.word
  description = Faker::Hipster.paragraph
  duration = Faker::Number.between(1, 10)
  Trip.create(name: name, description: description, duration: duration.day)
end

# user_trips
Trip.all.each do |trip|
  user = User.all.sample
  ratings = Faker::Number.between(0, 5)
  start_date = Faker::Date.forward(90)
  end_date = start_date + trip.duration
  travel_age = start_date.year - user.dob.year
  UserTrip.create(ratings: ratings, start_date: start_date, end_date: end_date, travel_age: travel_age, user_id: user.id, trip_id: trip.id)
end

# destinations
20.times do
  name = Faker::HarryPotter.location
  description = Faker::HarryPotter.quote
  lat = Faker::Address.latitude
  lng = Faker::Address.longitude
  Destination.create(name: name, description: description, lat: lat, lng: lng)
end

# activities
Trip.all.each do |trip|
  title = Faker::Coffee.blend_name
  description = Faker::Coffee.notes #=> "balanced, silky, marzipan, orange-creamsicle, bergamot"
  cost = Faker::Number.decimal(2)
  start_time = trip.user_trips.first.start_date
  end_time = start_time + 2.hour
  lat = Faker::Address.latitude
  lng = Faker::Address.longitude
  destination = Destination.all.sample
  Activity.create(title: title, description: description, cost: cost, start_time: start_time, end_time: end_time, lat: lat, lng: lng,trip_id: trip.id, destination_id: destination.id)
end
