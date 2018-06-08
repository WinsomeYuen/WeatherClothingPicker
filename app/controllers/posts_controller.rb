class PostsController < ApplicationController
  def index
    if params[:search]
      @posts = Post.search(params[:search])
    else
      @posts = nil;
    end
  end
end
