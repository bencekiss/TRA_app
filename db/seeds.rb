# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Account.create({name: "Yuri",
               email: "test@gmail.com",
               phone: "+16475299874",
               password: "password",
               secondary_name: "Bence",
               secondary_phone: "+14163561438",
               secondary_email: "test1@gmail.com",
               emergency_name: "Gee",
               emergency_phone: "+14164283530",
               patient_name: "Alex",
               patient_number: "+14164344772",
               patient_notes: "Key in the mailbox"})

Account.create({name: "Alex",
              email: "me@alexf.ca",
              phone: "+14164344772",
              password: "password",
              secondary_name: "Blah",
              secondary_phone: "+14164283530",
              secondary_email: "test1@gmail.com",
              emergency_name: "Gee",
              emergency_phone: "+14164283530",
              patient_name: "Alex",
              patient_number: "+16475299874",
              patient_notes: "Key in the mailbox"})

              Schedule.create({account_id: 1, schedule_time: Time.now + 1800, frequency_hours: 24})
              Schedule.create({account_id: 1, schedule_time: Time.now + 2400, frequency_hours: 24})
              Schedule.create({account_id: 2, schedule_time: Time.now + 3600, frequency_hours: 24})  
