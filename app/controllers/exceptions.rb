class Exceptions < Application
  
  # handle NotFound exceptions (404)
  def not_found
    render :format => :html, :layout => false
  end

  # handle NotAcceptable exceptions (406)
  def not_acceptable
    render :format => :html, :layout => false
  end

end