require 'rspec'
require 'tasks_repository'

describe TasksRepository do
  it "creates task items in a database" do
    db = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_database')
    db.create_table! :tasks_list do
      String :name
      boolean :completed
    end
    tasks = db[:tasks_list]

    list_of_tasks = TasksRepository.new(tasks)
    list_of_tasks.add('Task 1')
    list_of_tasks.add('Task 2')
    list_of_tasks.add('Task 3')
    expect(list_of_tasks.list_all).to eq [{name: 'Task 1', completed: false},
                                          {name: 'Task 2', completed: false},
                                          {name: 'Task 3', completed: false}]
  end
end