# Homepage (Root path)
get '/' do
  erb :index
end

# posts to /login
get '/login' do
  erb :login
end

#gets for teacher

get '/teacher' do
  # @users = User.all
  erb :'teacher/index'
end

get '/teacher/new_student' do
  # @student = Student.new
  erb :'teacher/new_student'
end

get '/teacher/homework/:id' do
  erb :'teacher/homework'
end

get '/teacher/new_homework' do
  # @homework = Homework.new
  erb :'teacher/new_homework'
end

get '/teacher/:id' do
  # @student = User.find params[:id]
  erb :'teacher/homework_show'
end

#gets for student

get '/student' do
  # @homework = Home.all
  erb :'student/index'
end

get '/student/:id' do
  # @homework = Homework.find params[:id]
  erb :'student/show'
end

# posts for teachers

post '/login' do
  username, password = params[:username], params[:password]
  user = User.find_by(username: username).try(:authenticate, password)
  if user
    session.delete(:error)
    session[:current_user] = user.id
    user.role == 'T' ? redirect('/teacher'): redirect('/student')
  else
    session.delete(:current_user)
    session[:error] = "Wrong username or password!"
    redirect '/login'
  end
end

helpers do
  def current_user
    User.find(session[:current_user])
  end
end
