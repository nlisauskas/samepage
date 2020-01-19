# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(first_name: "Nick", last_name: "Lisauskas", gender: "Male", password:'12345678', email: "nlisausk@alumni.nd.edu", birthdate: Time.strptime('08/28/1992 00:00', '%m/%d/%Y %H:%M'))
# Property.create!(street_1: "2132 W Barry Avenue", street_2: "", city: "Chicago", state: "Illinois", zipcode: 60618, purchase_price: 582500, purchase_date: Time.strptime('06/23/2017 00:00', '%m/%d/%Y %H:%M'))
# Tenant.create!(first_name: "John", last_name: "Smith", gender: "Male", birthdate: Time.strptime('08/28/1975 00:00', '%m/%d/%Y %H:%M'))
