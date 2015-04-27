helpers do
  def login?
    if session[:id].nil?
      return false
    else
      return true
    end
  end
end

get '/' do
  @user = User.find_by(id: session[:id])
  erb :index
end

get "/signup" do
  erb :signup
end

post '/signup' do
  user = User.create(params[:user])
  if user.valid?
    session[:id] = params[:user][:id]
    redirect "/"
  else
    @errors = user.errors.messages
    erb :index
  end
end

post '/login' do
  @user = User.find_by_email(params[:user][:email])
  # p @user.password
  # p params[:user][:password]
  if @user.password == params[:user][:password]
    session[:id] = @user.id
    redirect "/"
  else
    @errors = user.errors.messages
    erb :error
  end
end

get "/logout" do
  session[:id] = nil
  redirect "/"
end

get "/secret_page" do
  @user = User.find_by(id: session[:id])
  erb :secret_page
end
