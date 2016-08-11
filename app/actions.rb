# Homepage (Root path)
get '/' do
  erb :index
end

# posts to /login
get '/login' do
  erb :login
end

#gets for teacher

before '/teacher*' do
  redirect '/login' if !current_user
  redirect '/student' if current_user.role == 'S'
end

get '/teacher/students' do
  erb :'teacher/index'
end

get '/teacher/students/new' do
  @student = User.new
  erb :'teacher/new_student'
end

get '/teacher/students/:id/homework/new' do
  @homework = Homework.new
  @student = User.find params[:id]
  erb :'teacher/new_homework'
end

get '/teacher/student/:id' do
  @teacher = User.find(1)
  @student = User.find params[:id]
  erb :'teacher/homework'
end

get '/teacher/students/:id/homework/:id' do
  # @student = User.find params[:id]
  erb :'teacher/homework_show'
end

#gets for student

before '/student*' do
  redirect '/login' if !current_user
  redirect '/teacher/students' if current_user.role == 'T'
end

get '/student' do
  # @homework = Home.all
  erb :'student/index'
end

get '/student/homework/:id' do
  # @homework = Homework.find params[:id]
  erb :'student/show'
end

get '/student/:id/new_homework' do
  # @homework = Homework.find params[:id]
  @student = User.find params[:id]
  erb :'student/show'
end

# ----------- posts

post '/login' do
  username, password = params[:username], params[:password]
  user = User.find_by(username: username).try(:authenticate, password)
  if user
    session.delete(:error)
    session[:current_user] = user.id
    user.role == 'T' ? redirect('/teacher/students'): redirect('/student')
  else
    session.delete(:current_user)
    session[:error] = "Wrong username or password!"
    redirect '/login'
  end
end

post '/teacher/students' do
  @student = User.new(
    name: params[:name],
    username: params[:username],
    password: params[:password],
    role: "S",
    teacher_id: current_user.id
    )
    if @student.save
      redirect '/teacher/students'
    else
      erb :'/teacher/new_student'
    end
end

post '/homework/new' do
  @homework= Homework.new(
    title: params[:title],
    note: params[:note],
    user_id: params[:user_id],
  )

  if @homework.save
    redirect '/homework'
  else
    erb :'homework_new'
  end
end

post '/homework/:id/task' do
  @task = Task.new(
    item: params[:item],
    url: params[:url]
    )
  @task.save
  redirect '/teacher/students'
end

helpers do
  def current_user
    User.find(session[:current_user])
  end
end
