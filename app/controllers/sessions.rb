class Sessions < Application
  layout "login"
  
  def new
    render
  end

  def create
    self.current_user = User.authenticate(params[:email], params[:password])
    if logged_in?
      redirect_back_or_default('/')
    elsif params[:email] && params[:password]
      flash(:error, "Email and password provided do not match.<br/>#{"(You entered '#{params[:email]}' as email)" unless params[:email].blank?}" )
      render :new
    else
      render :new
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    session.delete
    # redirect_back_or_default('/')
    redirect '/forge-user-survey.html'
  end
  
end
