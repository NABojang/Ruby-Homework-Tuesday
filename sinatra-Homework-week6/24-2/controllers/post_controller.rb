class PostController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), "..")

  set :view, Proc.new { File.join(root, "views") }

  configure:development do
    register Sinatra::Reloader
  end

  # $posts = [
  #   {
  #     id: 0,
  #     title: "post 1",
  #     body: "This is the post 1 body (text)."
  #   },
  #   {
  #     id: 1,
  #     title: "post 2",
  #     body: "This is the post 2 body (text)."
  #   },
  #   {
  #     id: 2,
  #     title: "post 3",
  #     body: "This is the post 3 body (text)."
  #   }
  # ]

  get "/" do
    # "<h1>Hello Sinatra!</h1>"
    @title_homepage = "Homepage"
    @post = Post.all
    erb :'posts/index'
  end

  get "/new" do
    @post = Post.new
    #  {
    #   title: "",
    #   author: "",
    #   description: ""
    # }
    erb :'posts/new'
  end

  get "/:id" do
    id = params[:id].to_i
    @post = Post.find(id)
    erb :'posts/first'
  end

  get "/:id/edit" do
    id = params[:id].to_i
    @post = Post.find(id)
    erb :'posts/edit'
  end

  post '/' do
    post = Post.new
    post.title = params[:title]
    post.author = params[:author]
    post.description = params[:description]
    post.save
    redirect "/"
  end

  put '/:id' do
    id = params[:id].to_i
    # post = $posts[id]
    # post[:title] = params[:title]
    # post[:body] = params[:body]

    post =  Post.find id
    post.title = params[:title]
    post.author = params[:author]
    post.description = params[:description]
    post.save
    redirect '/'
  end

  delete '/:id' do
    id = params[:id].to_i
    post= Post.find id
    post.destroy
    redirect "/"
  end

end
