class Pages < Application

  def index(page = nil)
    @pages = Page.all
    render
  end
  
end
