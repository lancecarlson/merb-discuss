class MerbDiscuss::Forums < MerbDiscuss::Application
  before :ensure_admin, :only => [:new, :edit, :delete, :create, :update]
  
  def index
    @forums = MerbDiscuss::Forum.all
    render
  end

  def show(id)
    @forum = MerbDiscuss::Forum.get id
    @topics = @forum.topics
    render
  end

  def new
    @forum = MerbDiscuss::Forum.new
    render
  end

  def edit(id)
    @forum = MerbDiscuss::Forum.get id
    render
  end

  def delete
    render
  end

  def create
    @forum = MerbDiscuss::Forum.new(params["merb_discuss::forum"])
    if @forum.save
      redirect url(:forums)
    else
      render :new
    end
  end

  def update
    render
  end

  def destroy
    render
  end
  
  def ensure_admin
    true
  end
end
