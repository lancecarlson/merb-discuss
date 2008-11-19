require File.dirname(__FILE__) + '/../spec_helper'

describe "MerbDiscuss::Main (controller)" do
  
  # Feel free to remove the specs below
  
  before :all do
    Merb::Router.prepare { add_slice(:MerbDiscuss) } if standalone?
  end
  
  after :all do
    Merb::Router.reset! if standalone?
  end
  
  it "should have access to the slice module" do
    controller = dispatch_to(MerbDiscuss::Main, :index)
    controller.slice.should == MerbDiscuss
    controller.slice.should == MerbDiscuss::Main.slice
  end
  
  it "should have an index action" do
    controller = dispatch_to(MerbDiscuss::Main, :index)
    controller.status.should == 200
    controller.body.should contain('MerbDiscuss')
  end
  
  it "should work with the default route" do
    controller = get("/merb-discuss/main/index")
    controller.should be_kind_of(MerbDiscuss::Main)
    controller.action_name.should == 'index'
  end
  
  it "should work with the example named route" do
    controller = get("/merb-discuss/index.html")
    controller.should be_kind_of(MerbDiscuss::Main)
    controller.action_name.should == 'index'
  end
    
  it "should have a slice_url helper method for slice-specific routes" do
    controller = dispatch_to(MerbDiscuss::Main, 'index')
    
    url = controller.url(:merb_discuss_default, :controller => 'main', :action => 'show', :format => 'html')
    url.should == "/merb-discuss/main/show.html"
    controller.slice_url(:controller => 'main', :action => 'show', :format => 'html').should == url
    
    url = controller.url(:merb_discuss_index, :format => 'html')
    url.should == "/merb-discuss/index.html"
    controller.slice_url(:index, :format => 'html').should == url
    
    url = controller.url(:merb_discuss_home)
    url.should == "/merb-discuss/"
    controller.slice_url(:home).should == url
  end
  
  it "should have helper methods for dealing with public paths" do
    controller = dispatch_to(MerbDiscuss::Main, :index)
    controller.public_path_for(:image).should == "/slices/merb-discuss/images"
    controller.public_path_for(:javascript).should == "/slices/merb-discuss/javascripts"
    controller.public_path_for(:stylesheet).should == "/slices/merb-discuss/stylesheets"
    
    controller.image_path.should == "/slices/merb-discuss/images"
    controller.javascript_path.should == "/slices/merb-discuss/javascripts"
    controller.stylesheet_path.should == "/slices/merb-discuss/stylesheets"
  end
  
  it "should have a slice-specific _template_root" do
    MerbDiscuss::Main._template_root.should == MerbDiscuss.dir_for(:view)
    MerbDiscuss::Main._template_root.should == MerbDiscuss::Application._template_root
  end

end