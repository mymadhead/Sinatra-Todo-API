# frozen_string_literal: true

# Tasks Controller
class TasksController < ApplicationController
  include JwtHelper

  get '/tasks' do
    tasks = current_user.todos.includes(:tasks).find(params[:todo_id]).tasks
    tasks.to_json
  end

  get '/tasks/:id' do
    load_task.to_json
  end

  post '/tasks' do
    task = Task.new(params)
    if task.save
      task.to_json
    else
      halt 422, task.errors.full_messages.to_json
    end
  end

  put '/tasks/:id' do
    task = load_task
    if task.update(load_json)
      task.to_json
    else
      halt 422, task.errors.full_messages.to_json
    end
  end

  delete '/tasks/:id' do
    task = load_task
    if task.destroy_all
      { success: 'ok' }.to_json
    else
      halt 500
    end
  end

  private

  def load_task
    current_user.tasks.find(params[:id])
  end
end
