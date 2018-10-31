require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' if development?
require 'pg'
require_relative 'controllers/post_controller.rb'
require_relative 'models/post.rb'

use Rack::Reloader
use Rack::MethodOverride
run PostController
