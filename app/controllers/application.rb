class Application < Merb::Controller
  require Merb.root / 'lib' / 'auth_mixin'
  include AuthMixin
end