class PostsController < ApplicationController

  def index
    @posts = Post.order("id desc")
    posts_json = []

    for post in @posts 
      user = user.findby({"id" => post["user_id"]})
        if user 
        posts_json << {
          "username" => user["username"],
          "real_name" => user["real_name"],
          "body" => post["body"],
          "created_at" => post["created_at"]
        }
      end
    end

    respond_to do | format |
      format.html 
      format.json { render :json => posts_json }
  end



  def create
    @post = Post.new
    @post["body"] = params["body"]
    @post["user_id"] = session["user_id"]
    @post.save
    redirect_to "/posts"
  end

end
