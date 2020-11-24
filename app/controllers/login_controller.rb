class LoginController < ApplicationController


  def home
    if session[:user] != nil
      @typeUser = session[:user]['estAdmin']
      @username = session[:user]['username']
    else
      nilValue
    end
  end

  def login
    if session[:user]['username']
      @typeUser = session[:user]['estAdmin']
      @username = session[:user]['username']
    end
    puts "let's login"
    @user = User.new


  end


  def connect
    puts "Yeah you try to log in"
    username = get_params[:username]
    password = get_params[:password]
    user = User.find_by(username: username.downcase)
    if user && authenticate(user,username,password)
      # log in
      session[:user] = {id: user.id, username:user.username, estAdmin:user.estAdmin }
      puts session[:user]
      redirect_to root_path
    else
      # error message
      redirect_to login_path
    end
  end

  def disconnect
    session[:user].clear
    nilValue
    redirect_to root_path
  end

  # private methods
  #
  # Only allow a list of trusted parameters through.
  def get_params
    params.require(:user).permit(:username, :password)
  end

  def authenticate(user,username,password)
    if user[:username] == username && user[:password]== password
      true
    else
      false
    end
  end
  def nilValue
    @typeUser = nil
    @username = nil
  end

  # test
  def setSession
    session[:user][:id] = 1
    session[:user][:username] = 'heello'
    session[:user][:estAdmin] = 'admin'
    redirect_to root_path
  end

  def clear
    session[:user].clear
    nilValue
    redirect_to root_path
  end

  def put
    puts session[:user].inspect
    redirect_to root_path
  end

end
