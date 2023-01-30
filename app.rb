# frozen_string_literal: true

require 'byebug'
require 'dotenv'
require 'json'
require 'jwt'
require 'rake'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'sinatra/cross_origin'
require '../task-011/app/models/user'
require '../task-011/app/models/todo'
require '../task-011/app/models/task'
require '../task-011/config/cors'
require '../task-011/config/environment'
require '../task-011/app/helpers/jwt_helper'
require '../task-011/app/controllers/application_controller'
require '../task-011/app/controllers/tasks_controller'
require '../task-011/app/controllers/todos_controller'
require '../task-011/app/controllers/position_controller'
require '../task-011/app/controllers/users_controller'

Dotenv.load('.env')

# Main class
class App < Sinatra::Base
  use ApplicationController
  use UsersController
  use TodosController
  use TasksController
  use PositionController

  get '/' do
    content_type :html
    send_file './public/index.html'
  end
end
