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
    @comments = @page.comments.to_a.sort_by { |comment| comment.created_at }
    render
  end
  
  def preview
    render :show
  end
  
  def create_comment(id, comment, author)
    @author.set_attributes(author)
    @comment.set_attributes(comment.merge(:page => @page, :author => @author))
    if @author.save && @comment.save
      session[:author] = @author
      redirect url(:page, :id => @page.id)
    else
      render :show
    end
  end
  
  private
    def setup
      @page = RelaxDB.load(params[:id])
      @comment = Comment.new
      @comments = []
      @author =  session[:author] || Author.new
      @page_title = "#{@page.title} :: "
    end
end
