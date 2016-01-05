# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

school = School.create!(name: "TestSchool", ipads: 34,
  classrooms: ["Lazy", "Incompetent", "Selfish"])

school.teachers.create!(name: "TestAdmin", email: "test@ef.com",
  password: "password", password_confirmation: "password", admin: true)
