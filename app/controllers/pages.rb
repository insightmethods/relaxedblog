class Pages < Application

  def index(page = nil)
    @pages = Page.all.sorted_by(:created_at)
    render
  end
  
end
