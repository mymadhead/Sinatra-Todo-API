# frozen_string_literal: true

# Todos Controller
class TodosController < ApplicationController
  include JwtHelper

  def todos
    current_user.todos
  end

  get '/todos' do
    todos.to_json(include: :tasks)
  end

  get '/todos/:id' do
    find_todo.to_json(include: :tasks)
  end

  post '/todos' do
    todo = Todo.new(params)
    if todo.save
      todo.to_json(include: :tasks)
    else
      halt 422, todo.errors.full_messages.to_json
    end
  end

  put '/todos/:id' do
    todo = find_todo
    if todo.update(load_json)
      todo.to_json
    else
      halt 422, todo.errors.full_messages.to_json
    end
  end

  delete '/todos/:id' do
    todo = find_todo
    if todo.destroy_all
      { success: 'ok' }.to_json
    else
      halt 500
    end
  end

  def find_todo
    current_user.todos.find(params[:id])
  end
end
