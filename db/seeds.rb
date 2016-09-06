require 'faker'

User.create(
  name: "Leeroy Jenkins",
  username: "leeroy",
  password: "jenkins",
  role: "T"
)

first_name = Faker::Name.first_name
last_name = Faker::Name.last_name
parent = User.create(
  name: "#{first_name.capitalize} #{last_name.capitalize}",
  username: "#{first_name.downcase}",
  password: "parent",
  role: "P"
);

first_name = Faker::Name.first_name
last_name = Faker::Name.last_name
user = User.new(
  name: "#{first_name.capitalize} #{last_name.capitalize}",
  username: "#{first_name.downcase}",
  password: "student",
  role: "S"
)
user.teacher = User.find_by(name: "Leeroy Jenkins")
user.parent = parent
user.save!

homework_1 = Homework.new(
  title: "Week Two - C scale and G scale",
  note: "You did a great job with week. I want you to practice the G scale and the C scale. Keep up the good work!"
)
homework_1.user = User.find_by(name: "#{first_name.capitalize} #{last_name.capitalize}")
homework_1.save!

task_11 = Task.new(
  item: "Run through C scale 5 times",
  url: "https://www.youtube.com/watch?v=RpQI2gDv_T0",
  complete: false
)
task_11.homework = Homework.find_by(title: "Week Two - C scale and G scale")
task_11.save!

task_12 = Task.new(
  item: "Complete all G major and major 7 scale exercises",
  url: "https://en.wikipedia.org/wiki/G_major",
  complete: false
)
task_12.homework = Homework.find_by(title: "Week Two - C scale and G scale")
task_12.save!

homework_2 = Homework.new(
  title: "Week Three Review Practice",
  note: "This week, I want you to review the material from week three. You're doing a great job, but you should definitely be consistent with your practice."
)
homework_2.user = User.find_by(name: "#{first_name.capitalize} #{last_name.capitalize}")
homework_2.save!

task_21 = Task.new(
  item: "Read the attached material and think about the history of guitar",
  url: "http://www.guyguitars.com/eng/handbook/BriefHistory.html",
  complete: true
)
task_21.homework = Homework.find_by(title: "Week Three Review Practice")
task_21.save!

task_22 = Task.new(
  item: "Complete the guitar theory exercises in your journal and submit your response",
  url: "http://www.guitar-music-theory.com/theory/",
  complete: true
)
task_22.homework = Homework.find_by(title: "Week Three Review Practice")
task_22.save!

first_name = Faker::Name.first_name
last_name = Faker::Name.last_name
parent = User.create(
  name: "#{first_name.capitalize} #{last_name.capitalize}",
  username: "#{first_name.downcase}",
  password: "parent",
  role: "P"
);

first_name_2 = Faker::Name.first_name
last_name_2 = Faker::Name.last_name
user = User.new(
  name: "#{first_name_2.capitalize} #{last_name_2.capitalize}",
  username: "#{first_name_2.downcase}",
  password: "student",
  role: "S"
)
user.teacher = User.find_by(name: "Leeroy Jenkins")
user.parent = parent
user.save!

homework_3 = Homework.new(
  title: "C scale and G scale",
  note: "You did a great job with week. I want you to practice the G scale and the C scale. Keep up the good work!"
)
homework_3.user = User.find_by(name: "#{first_name_2.capitalize} #{last_name_2.capitalize}")
homework_3.save!

task_31 = Task.new(
  item: "Run through C scale 5 times",
  url: "https://www.youtube.com/watch?v=RpQI2gDv_T0",
  complete: false
)
task_31.homework = Homework.find_by(title: "C scale and G scale")
task_31.save!

task_32 = Task.new(
  item: "Complete all G major and major 7 scale exercises",
  url: "https://en.wikipedia.org/wiki/G_major",
  complete: false
)
task_32.homework = Homework.find_by(title: "C scale and G scale")
task_32.save!

homework_4 = Homework.new(
  title: "Monthly Review Practice",
  note: "This week, I want you to review the material from week three. You're doing a great job, but you should definitely be consistent with your practice."
)
homework_4.user = User.find_by(name: "#{first_name_2.capitalize} #{last_name_2.capitalize}")
homework_4.save!

task_41 = Task.new(
  item: "Read the attached material and think about the history of guitar",
  url: "http://www.guyguitars.com/eng/handbook/BriefHistory.html",
  complete: true
)
task_41.homework = Homework.find_by(title: "Monthly Review Practice")
task_41.save!

task_42 = Task.new(
  item: "Complete the guitar theory exercises in your journal and submit your response",
  url: "http://www.guitar-music-theory.com/theory/",
  complete: true
)
task_42.homework = Homework.find_by(title: "Monthly Review Practice")
task_42.save!
