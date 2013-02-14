class TasksController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Task.all
  end

  def show
    todo = Task.where(:id => params['id']).first

    if todo
      status = :ok
    else
      status = :not_found
    end
    respond_with todo, :status => status
  end

  def create
    task = Task.new(params['task'])
    if task.save
      status = :created
    else
      status = :internal_server_error # Yup, it could really be a :bad_request
                                      # series (model save failing validation)
    end  
    respond_with task, :status => status, :location => url_for(task)
  end

  def update
    task = Task.where(:id => params[:id]).first
    task.update_attributes(params['task'])
    if task.save
      # Am I imagining things or is rails-api stripping content here?
      # task is most definitely not nil, but spec/integration/tasks_spec.rb
      # behaves as though this is completely being ignored and returning
      # an empty response body and a status of 204. Hmmmm. 
      respond_with task, :status => :ok 
    else
      respond_with task.errors, :status => :internal_server_error
    end  
  end

  def destroy
    task = Task.where(:id => params[:id]).first
    unless task.destroy
      respond_with task.errors, :status => :internal_server_error
    else
      respond_with nil # status should automagically be 204 (no content). yay.
    end
  end

end
