class ApplicationController < ActionController::Base

  add_flash_types :info, :danger, :warning, :success

  def adminValidation
    if sessionValid?
      unless admin?
        #redirect_to forbiden_path
        render 'utils/403'
      end
    else
      disconnect
    end
    end

  def userValidation
    unless sessionValid?
      disconnect
    end
  end

  def sessionValid?

    #puts session[:user]
    # deconecté
    return true if session[:user] == nil || session[:user]['username'] == nil
    # session expiré
    return false if session[:user]['expiration'].to_time.past?
    return true
  end

  def admin?
    #puts ' ------------- Check ADMIN?'
    #puts session[:user]['estadmin']
    return true if session[:user]['estAdmin'] == 1
    return false
  end

  def disconnect
    session[:user].clear
    redirect_to root_path, warning: 'Votre session a éxpiré'
  end


end
