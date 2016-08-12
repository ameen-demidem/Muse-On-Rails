require 'json'

# Homepage (root path)
get '/' do
  erb :index
end

# gets for login/logout

# posts to /login
get '/login' do
  erb :login
end

get '/logout' do
  session[:current_user] = nil
  redirect '/'
end

get '/signup' do
  @teacher = User.new
  erb :signup
end

# gets for teacher

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
  @homework = (params[:homework] ? Homework.find(params[:homework]) : Homework.new)
  @student = User.find params[:id]
  erb :'teacher/new_homework'
end

get '/teacher/students/:id' do
  @student = User.find params[:id]
  erb :'teacher/homework'
end

# posts to "/teacher/students/homework/new_comment"
get '/teacher/students/:id/homework/:homework' do
  @student = User.where(id: params[:id]).first
  redirect "/teacher/students" if !@student

  @homework = Homework.where(id: params[:homework]).first
  redirect "teacher/students/#{params[:id]}" if !@homework

  redirect "teacher/students/#{params[:id]}" if !@student.homeworks.include? @homework

  erb :'teacher/student_homework'
end

# gets for student

before '/student*' do
  redirect '/login' if !current_user
  redirect '/teacher/students' if current_user.role == 'T'
end

get '/student' do
  # @homework = Home.all
  erb :'student/index'
end

# posts to "/student/homework/new_comment"
get '/student/homework/:id' do
  @homework = Homework.where(id: params[:id]).first
  redirect "/student" if !@homework

  redirect "/student" if !current_user.homeworks.include? @homework

  erb :'student/show_homework'
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

post '/signup' do
  @teacher = User.new(
    name: params[:name],
    username: params[:username],
    password: params[:password],
    role: "T",
  )
  if @teacher.save
    redirect '/login'
  else
    erb :'/signup'
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
    redirect "/teacher/students/#{params[:user_id]}/homework/new?homework=#{@homework.id}"
  else
    erb :'homework_new'
  end
end

post '/homework/:id/task' do
  @task = Task.new(
    item: params[:item],
    url: params[:url],
    homework_id: params[:id]
    )
  if @task.save
    redirect "/teacher/students/#{params[:user_id]}/homework/new?homework=#{@task.homework_id}"
  else
    erb :'homework_new'
  end
end

post '/teacher/students/homework/new_comment' do
  Comment.create(
    feedback: params[:feedback], url: params[:url],
    homework_id: params[:homework_id], user_id: session[:current_user]
  )
  redirect "/teacher/students/#{params[:student_id]}/homework/#{params[:homework_id]}"
end

# came here from '/student/homework/:id'
post "/student/homework/new_comment" do
  Comment.create(
    feedback: params[:feedback], url: params[:url],
    homework_id: params[:homework_id], user_id: session[:current_user]
  )
  redirect "/student/homework/#{params[:homework_id]}"
end

post '/student/homework/task_update' do
  homework = Homework.where(id: params[:homework]).first
  return if !homework

  task = Task.where(id: params[:task]).first
  return if !task

  return unless homework.tasks.include? task

  task.complete = params[:done]
  task.save
end

helpers do
  def current_user
    User.find(session[:current_user])
  end

  def teacher?
    current_user.teacher_id.nil?
  end

  def not_logged_in
    session[:current_user].nil?
  end

  def youtube?(url)
    url =~ /(youtube|youtu.be)/
  end

  def youtubify(url)
    if youtube?(url)
      "<iframe width='400' height='300' " +
        "src='#{url.sub(/watch\?v=/, "embed/")}' " +
        "frameborder='0' allowfullscreen>" +
      "</iframe>"
    else
      "<a href='#{url}'>Resources ...</a>"
    end
  end
end
