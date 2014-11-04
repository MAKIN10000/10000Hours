class ApplicationController < ActionController::Base
  protect_from_forgery

  def set_current_user
    @current_user ||= session[:session_token] && User.find_by_session_token(session[:session_token])
 	if @current_user 
 		puts "asdfjas;djgiosdgSDFGSDFG;OIN;OIENR;OGINA;OSIN;FOINASOI #{@current_user.user_id}"
  	end
  end

end

