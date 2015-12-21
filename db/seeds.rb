# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

school = School.create(name: "Shanghai 10", ipads: 34)

jared = school.teachers.create(name: "Jared", email: "jared.kobos@ef.com", password: "password",
  password_confirmation: "password", admin: true)
klavier = school.teachers.create(name: "Klavier", email: "klavier.min@ef.com",
  password: "password", password_confirmation: "password", admin: false)

classroom = school.classrooms.create([{name: "Success"}, {name: "Confidence"}, {name: "Adaptable"}])
