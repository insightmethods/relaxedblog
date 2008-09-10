class Publish < Application
  layout "admin"
  
  def all
    @pages = Page.all
    render
  end
  
  def new
    @page = Page.new
    render
  end
  
  def edit(id)
    @page = RelaxDB.load(id)
    raise NotFound unless @page
    render
  end
  
  def create(page)
    @page = Page.new(page)
    if @page.save
      redirect url(:publish, :action => :all)
    else
      render :edit
    end
  end
  
  def update(id, page)
    @page = RelaxDB.load(id)
    raise NotFound unless @page
    @page.set_attributes(page)
    if @page.save
      redirect url(:publish, :action => :all)
    else
      render :edit
    end
  end
  
  def destroy(id)
    @page = RelaxDB.load(id)
    raise NotFound unless @page
    RelaxDB.db.delete("#{@page._id}?rev=#{@page._rev}")
    # @page.destroy!
    redirect url(:publish, :action => :new)
  end
  
end
