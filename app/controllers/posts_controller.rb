class PostsController < ApplicationController

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    conn = Bunny.new(:automatically_recover => false)
    conn.start

    ch   = conn.create_channel
    q    = ch.queue("main")

    ch.default_exchange.publish(@post.body, :routing_key => q.name)

    redirect_to posts_url, notice: 'Text was successfully added.'

    conn.close
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:body)
    end
end
