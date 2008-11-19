class MerbDiscuss::Topics < MerbDiscuss::Application
  # provides :xml, :yaml, :js

  def index
    @topics = Topic.all
    display @topics
  end

  def show(id)
    @topic = Topic.get(id)
    raise NotFound unless @topic
    display @topic
  end

  def new
    only_provides :html
    @topic = Topic.new
    display @topic
  end

  def edit(id)
    only_provides :html
    @topic = Topic.get(id)
    raise NotFound unless @topic
    display @topic
  end

  def create(topic)
    @topic = Topic.new(topic)
    if @topic.save
      redirect resource(@topic), :message => {:notice => "Topic was successfully created"}
    else
      message[:error] = "Topic failed to be created"
      render :new
    end
  end

  def update(id, topic)
    @topic = Topic.get(id)
    raise NotFound unless @topic
    if @topic.update_attributes(topic)
       redirect resource(@topic)
    else
      display @topic, :edit
    end
  end

  def destroy(id)
    @topic = Topic.get(id)
    raise NotFound unless @topic
    if @topic.destroy
      redirect resource(:topics)
    else
      raise InternalServerError
    end
  end

end # Topics
