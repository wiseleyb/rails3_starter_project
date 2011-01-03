class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_ownership, :only => [:edit, :update, :destroy]
  before_filter :load_forum_topic

  uses_tiny_mce :only => [:new, :edit], 
                :options => {
                              :theme => 'advanced',
                              :theme_advanced_toolbar_location => "top"
                            }

  def load_forum_topic
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
  end
  
  def authenticate_ownership
    current_user.id == Post.find(params[:id]).user_id
  end

  # GET /posts
  # GET /posts.xml
  def index
    @posts = @topic.posts

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    params[:post][:topic_id] = @topic.id
    params[:post][:user_id] = current_user.id
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(forum_topic_post_path(@forum, @topic, @post), :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    params[:post][:topic_id] = @topic.id
    params[:post][:user_id] = current_user.id
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(forum_topic_post_path(@forum, @topic, @post), :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(forum_topic_posts_path(@forum, @topic)) }
      format.xml  { head :ok }
    end
  end
    
end
