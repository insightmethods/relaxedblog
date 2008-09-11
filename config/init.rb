$KCODE = 'UTF8'

dependency "merb-builder"
dependency "merb_relaxdb"
dependencies "merb-action-args", "merb-assets", "merb-jquery"
dependency "merb_helpers"
dependency "merb_coderay_helpers"

Merb::BootLoader.after_app_loads do
  
end

use_test :rspec

use_template_engine :erb
use_template_engine :haml


Merb::Config.use do |c|
  c[:session_secret_key]  = '2a03274f2e86c5c46aeb5e88d3ac160877874346'
  c[:session_store] = 'cookie'
  
  # Other configs
  # Merb::Config[:sass] = {:style => :compressed}
end

Merb.add_mime_type(:atom, nil,%w[application/atom+xml])
