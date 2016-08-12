require 'faker'

User.create(
  name: "Thomas Hamilton",
  username: "thomas",
  password: "hamilton",
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

  3.times {
    title = Faker::Hipster.sentence
    note = Faker::Hipster.paragraph
    homework = Homework.new(
      title: "#{title}",
      note: "#{note}"
    )
    homework.user = User.find_by(name: "#{first_name.capitalize} #{last_name.capitalize}")
    homework.save!

    3.times {
      item = Faker::Hipster.sentence
      task = Task.new(
        item: "#{item}",
        complete: false
      )
      task.homework = Homework.find_by(title: "#{title}")
      task.save!
    }
  }
}

User.create(
  name: "Chris Buscarino",
  username: "chris",
  password: "buscarino",
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
  user.teacher = User.find_by(name: "Chris Buscarino")
  user.save!

  3.times {
    title = Faker::Hipster.sentence
    note = Faker::Hipster.paragraph
    homework = Homework.new(
      title: "#{title}",
      note: "#{note}"
    )
    homework.user = User.find_by(name: "#{first_name.capitalize} #{last_name.capitalize}")
    homework.save!

    3.times {
      item = Faker::Hipster.sentence
      task = Task.new(
        item: "#{item}",
        complete: false
      )
      task.homework = Homework.find_by(title: "#{title}")
      task.save!
    }
  }
}
