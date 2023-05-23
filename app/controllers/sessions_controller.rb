class SessionsController < ApplicationController
  def new
  end

  def create
    # Look up User in db by the email address submitted to the login form and
    # convert to lowercase to match email in db in case they had caps lock on:
    # user = User.find_by(email: params[:login][:email].downcase) - used prior to defining authenticate_with_credentials method in user model
    # If the user exists AND the password entered is correct.
    if user.authenticate_with_credentials(params[:login][:password])
      # user && user.authenticate(params[:login][:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id.to_s
      redirect_to root_path, notice: 'Successfully logged in!'
    else
    # If user's login doesn't work, send them back to the login form.
    flash.now.alert = "Incorrect email or password, try again."
    render :new
    end
  end

  def destroy
    # delete the saved user_id key/value from the cookie:
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"
  end

end
