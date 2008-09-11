class Pages < Application
  before :setup, :only => [:show]
  
  def index(page = nil)
    provides :html, :atom
    @pages = Page.all.sorted_by(:created_at).reverse
    render 
  end
  
  def show
    render
  end
  
  private
    def setup
      @page = RelaxDB.load(params[:id])
      @page_title = "#{@page.title} :: "
    end
end
