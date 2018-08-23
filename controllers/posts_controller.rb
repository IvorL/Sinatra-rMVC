class PostsController < Sinatra::Base

  # Sets the root as the parent-directory of the current File
  set :root, File.join(File.dirname(__FILE__), '..')

  # Sets the view directory correctly
  set :views, Proc.new {File.join(root, 'views')}

  configure :development do
    register Sinatra::Reloader
  end

# Data that is manipulated using the 7 routes
  $posts = [{
      id:0,
      title: 'Lasagne',
      post_body: 'This is the recipe information to make a lasagne'
    },
    {
      id:1,
      title: 'Pizza',
      post_body: 'This is the recipe information to make a pizza'
    },
    {
      id:2,
      title: 'Shepherds Pie',
      post_body: 'This is the recipe information to make a shepherds pie'
    },
    {
      id:3,
      title: 'Brownies',
      post_body: 'This is the recipe information to make brownies'
    }]

# get request that returns all recipes
  get "/" do
    @title = "Recipes"
    @posts = $posts
    erb :'posts/index'
  end

# Get request that returns an HTML form, created using the HTML form template, to add a new recipe. A post request using the form input adds the new recipe
  get "/new" do
    @title = "New Recipe"
    @post = {
      id: "",
      title: "",
      post_body: ""
    }
    erb :'posts/new'
  end

# Get request that return a recipe with a unique id number
  get "/:id" do
    id = params[:id].to_i
    @post = $posts[id]
    erb :'posts/show'
  end

# Get request that returns an HTML form to edit a recipe with a unique id. The form details are used to make a put request to update the recipe
  get "/:id/edit" do
    id = params[:id].to_i
    @post = $posts[id]
    erb :'posts/edit'
  end

# Post request that captures the information from an HTML form and creates a new recipe. Redirects to the homepage
  post "/" do
    new_post = {
      id: $posts.length,
      title: params[:title],
      post_body: params[:post_body]
    }

    $posts.push(new_post)

    redirect "/"
  end

# Data from the inout form for edit is used to make a put request to update the recipe selcted by unique id. Redirects to the homepage
  put "/:id" do
    id = params[:id].to_i
    post = $posts[id]
    post[:title] = params[:title]
    post[:post_body] = params[:post_body]
    $posts[id] = post

    redirect "/"
  end

# Delete request that removes a recipe from the server and redirectes to the homepage
  delete "/:id" do
    id = params[:id].to_i
    $posts.delete_at(id)
    redirect "/"
  end

end
