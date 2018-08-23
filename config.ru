require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' if development?
require 'pry'
require_relative './controllers/posts_controller.rb'

use Rack::Reloader
use Rack::MethodOverride
# Direct the request to the correct controller
run PostsController
