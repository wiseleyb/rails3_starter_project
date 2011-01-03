class BlogCommentsController < ApplicationController

  before_filter :authenticate_user!, :except => [:new, :create]
  before_filter :authenticate_ownership, :only => [:edit, :update, :destroy]
  before_filter :load_blog_blog_entry
  
  uses_tiny_mce :only => [:edit, :show], 
                :options => {
                              :theme => 'advanced',
                              :theme_advanced_toolbar_location => "top"
                            }
  def authenticate_ownership
    current_user.id == BlogComment.find(params[:id]).user_id
  end

  def load_blog_blog_entry
    @blog = Blog.find(params[:blog_id])
    @blog_entry = BlogEntry.find(params[:blog_entry_id])
  end

  # GET /blog_comments/1/edit
  def edit
    @blog_comment = BlogComment.find(params[:id])
  end


  # GET /blog_comments/new
  # GET /blog_comments/new.xml
  def new
    @blog_comment = BlogComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blog_comment }
    end
  end
  
  # POST /blog_comments
  # POST /blog_comments.xml
  def create
    @blog_comment = BlogComment.new(params[:blog_comment])
    @blog_comment.user_id = current_user.id if user_signed_in?
    @blog_comment.blog_entry_id = @blog_entry.id
    respond_to do |format|
      if @blog_comment.save
        format.html { redirect_to(blog_blog_entry_path(@blog, @blog_entry), :notice => 'Blog comment was successfully created.') }
        format.xml  { render :xml => @blog_comment, :status => :created, :location => @blog_comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @blog_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blog_comments/1
  # PUT /blog_comments/1.xml
  def update
    @blog_comment = BlogComment.find(params[:id])
    @blog_comment.user_id = current_user.id if user_signed_in?
    @blog_comment.blog_entry_id = @blog_entry.id
    respond_to do |format|
      if @blog_comment.update_attributes(params[:blog_comment])
        format.html { redirect_to(blog_blog_entry_path(@blog, @blog_entry), :notice => 'Blog comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_comments/1
  # DELETE /blog_comments/1.xml
  def destroy
    @blog_comment = BlogComment.find(params[:id])
    @blog_comment.destroy

    respond_to do |format|
      format.html { redirect_to(blog_blog_entry_path(@blog, @blog_entry)) }
      format.xml  { head :ok }
    end
  end
end
