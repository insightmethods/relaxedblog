module Merb
  module GlobalHelpers
    def show_flash(type = :info)
      @flash = session[:flash][type] if session[:flash]
      unless @flash.blank?
        session[:flash][type] = nil 
        "<ul class=#{type}><li>#{@flash}</li></ul>" 
      end
    end
    
    def flash(type, notice)
      session[:flash] ||= {}
      session[:flash][type] = notice
    end
  end
end
