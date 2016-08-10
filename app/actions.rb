# Homepage (Root path)
get '/' do
  erb :index
end

get '/login' do
  erb :login
end

#gets for teacher

get '/teacher' do
  # @users = User.all
  erb :'teacher/index'
end

get '/teacher/homework' do
  erb :'teacher/homework'
end

get '/teacher/new_homework' do
  # @homework = Homework.new
  erb :'teacher/new_homework'
end

get '/teacher/new_student' do
  # @student = Student.new
  erb :'teacher/new_student'
end

get '/teacher/:id' do
  # @student = User.find params[:id]
  erb :'teacher/show'
end

#gets for student

get '/student' do
  # @homework = Home.all
  erb :'teacher/index'
end

get '/student/:id' do
  # @homework = Homework.find params[:id]
  erb :'teacher/show'
end
