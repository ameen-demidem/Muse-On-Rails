require 'faker'

User.create(
  name: "Thomas Hamilton",
  username: "thomas",
  password: "hamilton",
  role: "T"
)

User.create(
  name: "Chris Buscy",
  username: "chris",
  password: "buscy",
  role: "T"
)

2.times {
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = User.new(
    name: "#{first_name.capitalize} #{last_name.capitalize}",
    username: "#{first_name.downcase}",
    password: "#{last_name.downcase}",
    role: "S"
  )
  user.teacher = User.find_by(name: "Thomas Hamilton")
  user.save!
}


2.times {
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = User.new(
    name: "#{first_name.capitalize} #{last_name.capitalize}",
    username: "#{first_name.downcase}",
    password: "#{last_name.downcase}",
    role: "S"
  )
  user.teacher = User.find_by(name: "Chris Buscy")
  user.save!
}
