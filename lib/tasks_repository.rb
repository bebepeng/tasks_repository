require 'sequel'

class TasksRepository

  def initialize(tasks)
   @tasks = tasks
  end

  def add(task, completed = false)
    @tasks.insert(:name => task, :completed => completed)
  end

  def delete(task)
    @tasks.where(:name => task).delete
  end

  def list_all
    @tasks.to_a
  end
end