class Sessions < Application
  layout "login"
  
  def new
    render
  end

  def create(username, password)
    self.current_user = User.authenticate(username, password)
    if logged_in?
      redirect_back_or_default('/admin')
    elsif username && password
      flash(:error, "Email and password provided do not match.<br/>#{"(You entered '#{params[:email]}' as email)" unless params[:email].blank?}" )
      render :new
    else
      render :new
    end
  end

  def destroy
    current_user.forget_me if logged_in?
    session.delete
    redirect_back_or_default('/')
  end
  
end