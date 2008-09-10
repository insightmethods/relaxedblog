class Pages < Application

  def index(page = nil)
    provides :html, :atom
    @pages = Page.all.sorted_by(:created_at).reverse
    render 
  end
  
end
