class Pages < Application
  before :setup, :only => [:show, :preview, :create_comment]
  before :login_required, :only => [:preview]
  
  def index(page = nil)
    provides :html, :atom
    @pages = Page.all.sorted_by(:created_at).reverse.select do |page| 
      !!page.published 
    end
    render 
  end
  
  def show
    raise NotFound unless @page.published
    render
  end
  
  def preview
    render :show
  end
  
  def create_comment(id, comment)
    @comment.set_attributes(comment.merge(:page => @page))
    if @comment.save
      render :show
    else
      redirect url(:page, :id => @page.id)
    end
  end
  
  private
    def setup
      @page = RelaxDB.load(params[:id])
      @comment = Comment.new
      @page_title = "#{@page.title} :: "
    end
end
