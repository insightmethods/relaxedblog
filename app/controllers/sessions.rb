class Sessions < Application
  layout "login"
  
  def new
    render
  end

  def create(username, password)
    self.current_user = User.authenticate(username, password)
    if logged_in?
      redirect url(:publish, :action => "all")
    elsif username && password
      flash(:error, "Username and password provided do not match")
      render :new
    else
      render :new
    end
  end

  def destroy
    self.current_user = nil
    redirect '/'
  end
  
end
