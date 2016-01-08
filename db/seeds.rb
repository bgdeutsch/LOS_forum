# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create![{name:  "Dutchy",
             email: "bgdeutsch@gmail.com",
             password:              "passw0rd",
             password_confirmation: "passw0rd",
             isadmin: true,
             titles: 0,
             sackos: 3}]

User.create![{name:  "Joseph",
              email: "jklages826@yahoo.com",
              password:              "jacksonwax",
              password_confirmation: "jacksonwax",
              isadmin: true,
              titles: 0,
              sackos: 3}]
