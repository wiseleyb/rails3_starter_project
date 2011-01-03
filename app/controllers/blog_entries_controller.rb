class BlogEntriesController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_ownership, :only => [:edit, :update, :destroy]
  before_filter :load_blog
  
  uses_tiny_mce :only => [:new, :edit, :show], 
                :options => {
                              :theme => 'advanced',
                              :theme_advanced_toolbar_location => "top"
                            }

  def authenticate_ownership
    current_user.id == BlogEntry.find(params[:id]).user_id
  end

  def load_blog
    @blog = Blog.find(params[:blog_id])
  end
  
  # GET /blog_entries
  # GET /blog_entries.xml
  def index
    @blog_entries = BlogEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blog_entries }
    end
  end

  # GET /blog_entries/1
  # GET /blog_entries/1.xml
  def show
    @blog_entry = BlogEntry.find(params[:id])
    
    @blog_comment = BlogComment.new
    if user_signed_in?
      @blog_comment.name = current_user.name
      @blog_comment.email = current_user.email
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @blog_entry }
    end
  end

  # GET /blog_entries/new
  # GET /blog_entries/new.xml
  def new
    @blog_entry = BlogEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blog_entry }
    end
  end

  # GET /blog_entries/1/edit
  def edit
    @blog_entry = BlogEntry.find(params[:id])
  end

  # POST /blog_entries
  # POST /blog_entries.xml
  def create
    params[:blog_entry][:user_id] = current_user.id
    params[:blog_entry][:blog_id] = @blog.id
    @blog_entry = BlogEntry.new(params[:blog_entry])

    respond_to do |format|
      if @blog_entry.save
        format.html { redirect_to(blog_blog_entry_path(@blog, @blog_entry), :notice => 'Blog entry was successfully created.') }
        format.xml  { render :xml => @blog_entry, :status => :created, :location => @blog_entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @blog_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blog_entries/1
  # PUT /blog_entries/1.xml
  def update
    @blog_entry = BlogEntry.find(params[:id])
    params[:blog_entry][:user_id] = current_user.id
    params[:blog_entry][:blog_id] = @blog.id
    
    respond_to do |format|
      if @blog_entry.update_attributes(params[:blog_entry])
        format.html { redirect_to(blog_blog_entry_path(@blog, @blog_entry), :notice => 'Blog entry was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_entries/1
  # DELETE /blog_entries/1.xml
  def destroy
    @blog_entry = BlogEntry.find(params[:id])
    @blog_entry.destroy

    respond_to do |format|
      format.html { redirect_to(blog_blog_entries_url(@blog)) }
      format.xml  { head :ok }
    end
  end
end
