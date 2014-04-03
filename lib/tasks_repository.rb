require 'sequel'

class TasksRepository

  def initialize
    db = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_database')
    db.create_table! :tasks_list do
      primary_key :id
      String :name
      Integer :priority
    end
    @tasks = db[:tasks_list]
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