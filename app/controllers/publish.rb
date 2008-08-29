class Publish < Application

  def new(page = nil)
    @pages = Page.new
    render
  end
  
end
