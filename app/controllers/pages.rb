class Pages < Application

  def index(page = nil)
    provides :html, :atom
    @pages = Page.all.sorted_by(:created_at).reverse
    render 
  end
  
  def show(id)
    @page = RelaxDB.load(id)
    render
  end
  
end
