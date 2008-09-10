xml.instruct! :xml, :version=>"1.0" 
xml.feed(:xmlns => "http://www.w3.org/2005/Atom") do |feed|
  feed.title('InsightMethods')
  feed.link('http://blog.insightmethods.com/')
  @pages.each do |page|
    feed.entry do |entry|
      entry.id(page.id)
      url = absolute_url(:page, :id => page.id)
      entry.link(url)
      entry.title(page.title)
      entry.content(page.content_html, :type => 'text')
      entry.updated(page.updated_at)
      if page.author
        entry.author(page.author.name)
      end
    end
  end
end