require 'sequel'

class TasksRepository

  def initialize(tasks)
   @tasks = tasks
  end

  def add(task, priority)
    #  add will insert items into the database
    @tasks.insert(:name => task, :priority => priority)
  end

  def list_all
    #  list all will list all of the rows in the database
    @tasks.to_a
  end
end