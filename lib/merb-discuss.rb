if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  load_dependency 'merb-slices'
  Merb::Plugins.add_rakefiles "merb-discuss/merbtasks", "merb-discuss/slicetasks", "merb-discuss/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :merb-discuss
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:merb_discuss][:layout] ||= :merb_discuss
  
  # All Slice code is expected to be namespaced inside a module
  module MerbDiscuss
    
    # Slice metadata
    self.description = "MerbDiscuss is a chunky Merb slice!"
    self.version = "0.0.1"
    self.author = "Lance Carlson"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(MerbDiscuss)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :merb_discuss_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      # example of a named route
      scope.resources :forums
      scope.resources :posts
      scope.match('/index(.:format)').to(:controller => 'main', :action => 'index').name(:index)
      # the slice is mounted at /merb-discuss - note that it comes before default_routes
      scope.match('/').to(:controller => 'main', :action => 'index').name(:home)
      # enable slice-level default routes by default
      # scope.default_routes
    end
    
  end
  
  # Setup the slice layout for MerbDiscuss
  #
  # Use MerbDiscuss.push_path and MerbDiscuss.push_app_path
  # to set paths to merb-discuss-level and app-level paths. Example:
  #
  # MerbDiscuss.push_path(:application, MerbDiscuss.root)
  # MerbDiscuss.push_app_path(:application, Merb.root / 'slices' / 'merb-discuss')
  # ...
  #
  # Any component path that hasn't been set will default to MerbDiscuss.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  MerbDiscuss.setup_default_structure!
  
  # Add dependencies for other MerbDiscuss classes below. Example:
  # dependency "merb-discuss/other"
  dependencies "merb-assets", "merb-helpers"
  dependencies "dm-types", "dm-validations"
  
end