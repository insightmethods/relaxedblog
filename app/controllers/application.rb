class Application < Merb::Controller
  require Merb.root / 'app' / 'helpers' / 'global_helpers'
  include Merb::GlobalHelpers
end