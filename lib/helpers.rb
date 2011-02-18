module CurrencyWatcher
  module Helpers
    instance_eval do
      helpers do
        def render_main_menu
          res = ""
          [
            {:label => 'Home', :path => '/'},
            {:label => 'O stronie', :path => '/o'}
            #TODO: write some basic articles
#            {:label => 'Ryzyko', :path => '/ryzyko'},
#            {:label => 'Spread', :path => '/spread'}
          ].each do |item|
            res += menu_item(item[:label], item[:path])  
          end
          return res
        end

        def menu_item(label, path)
            css_class = request.path_info == path ? 'active' : ''
            return "<li class=\"#{css_class}\"><a href=\"#{path}\">#{label}</a></li>"
        end
      end
    end
  end
end
