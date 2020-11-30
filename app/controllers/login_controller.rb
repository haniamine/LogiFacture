class LoginController < ApplicationController

  $expiration = 5 # minutes

  def setExpiration
    return $expiration.minutes.from_now
  end

  def home
    userValidation
  end

  def login
    @user = User.new
  end


  def connect
    username = get_params[:username]
    password = get_params[:password]
    user = User.find_by(username: username.downcase)
    if user && authenticate(user,username,password)
      # log in
      session[:user] = {:id => user.id, :username=>user.username, :estAdmin=>user.estAdmin, :expiration => setExpiration}
      puts session[:user]
      redirect_to factures_path
    else
      # error message
      redirect_to login_path, danger: 'Vos identifiant sont incorrect!'
    end
  end

  def disconnect
    session[:user].clear
    redirect_to root_path, success: 'Déconnexion réussie !'
  end


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

  # test
  def setSession
    # session[:user][:id] = 1
    # session[:user][:username] = 'aaa'
    # session[:user][:estAdmin] = 1
    # session[:user][:expiration] = $expiration
    puts 'Session set'
    session[:user] = {:id => 1, :username=>'aaa', :estAdmin=>1, :expiration => setExpiration}
    puts session[:user].inspect
    redirect_to root_path
  end

  def clear
    session[:user].clear
    redirect_to root_path
  end

  def put
    puts session[:user].inspect
    redirect_to root_path
  end

end
