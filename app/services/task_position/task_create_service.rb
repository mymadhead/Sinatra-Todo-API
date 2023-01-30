# frozen_string_literal: true

module TaskPositionService
  # Service for creating tasks
  class TaskCreateService < ApplicationService
    def initialize(params, tasks)
      @tasks = tasks
      @params = params
    end

    def call
      create_task
    end

    private

    attr_reader :params, :tasks

    def create_task
      tasks.create(body: params[:body])
    end
  end
end
