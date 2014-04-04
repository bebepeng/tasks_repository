require 'sequel'

class TasksRepository

  def initialize(tasks)
    @tasks = tasks
  end

  def add(task, completed = false)
    @tasks.insert(:name => task, :completed => completed)
  end

  def edit(task, changes)
    @tasks.where(:name => task).update(changes)
  end

  def delete(task)
    @tasks.where(:name => task).delete
  end

  def list(task)
    @tasks.where(:name => task).to_a
  end

  def list_tasks
    @tasks.select(:name).to_a
  end

  def list_all
    @tasks.to_a
  end
end