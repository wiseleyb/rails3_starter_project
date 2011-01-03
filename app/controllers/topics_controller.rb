class TopicsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_ownership, :only => [:edit, :update, :destroy]
  before_filter :load_forum

  uses_tiny_mce :only => [:new, :edit], 
                :options => {
                              :theme => 'advanced',
                              :theme_advanced_toolbar_location => "top"
                            }

  def load_forum
    @forum = Forum.find(params[:forum_id])
  end
  
  def authenticate_ownership
    params[:topic][:user_id] = current_user.id
    current_user.id == Topic.find(params[:id]).user_id
  end
  
  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
      format.rss  { redirect_to forum_topic_path(@forum, @topic, :format => :atom), :status => :moved_permanently}
      format.atom { }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.xml
  def create
    params[:topic][:user_id] = current_user.id
    params[:topic][:forum_id] = @forum.id
    @topic = Topic.new(params[:topic])

    respond_to do |format|
      if @topic.save
        format.html { redirect_to(forum_topic_path(@forum, @topic), :notice => 'Topic was successfully created.') }
        format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])
    params[:topic][:forum_id] = @forum.id
    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(forum_topic_path(@forum, @topic), :notice => 'Topic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(forum_url(@forum)) }
      format.xml  { head :ok }
    end
  end
end
