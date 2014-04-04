require 'rspec'
require 'tasks_repository'

describe TasksRepository do
  before do
    db = Sequel.connect('postgres://gschool_user:gschool_user@localhost:5432/tasks_database')
    db.create_table! :tasks_list do
      String :name
      boolean :completed
    end
    @tasks = db[:tasks_list]
  end

  it "creates task items in a database" do

    list_of_tasks = TasksRepository.new(@tasks)
    list_of_tasks.add('Task 1')
    list_of_tasks.add('Task 2')
    list_of_tasks.add('Task 3')
    expect(list_of_tasks.list_all).to eq [{name: 'Task 1', completed: false},
                                          {name: 'Task 2', completed: false},
                                          {name: 'Task 3', completed: false}]
  end

  it "deletes task itmes in a database" do
    list_of_tasks = TasksRepository.new(@tasks)
    list_of_tasks.add('Task 1')
    list_of_tasks.add('Task 2')
    list_of_tasks.delete('Task 1')
    expect(list_of_tasks.list_all).to eq [{name: 'Task 2', completed: false}]
  end

  it "edits task itmes in a database" do
    list_of_tasks = TasksRepository.new(@tasks)
    list_of_tasks.add('Task 1')
    list_of_tasks.add('Task 2')
    list_of_tasks.edit('Task 1', {:name => 'Task new', :completed => true})
    list_of_tasks.edit('Task 2', {:completed => true})
    expect(list_of_tasks.list_all).to eq [{name: 'Task new', completed: true},
                                          {name: 'Task 2', completed: true}]
  end

  it "searches tasks items by name" do
    list_of_tasks = TasksRepository.new(@tasks)
    list_of_tasks.add('Task 1')
    list_of_tasks.add('Task 2')
    expect(list_of_tasks.list('Task 2')).to eq [{name: 'Task 2', completed: false}]
  end

  it "prints all the tasks" do
    list_of_tasks = TasksRepository.new(@tasks)
    list_of_tasks.add('Task 1')
    list_of_tasks.add('Task 2')
    expect(list_of_tasks.list_tasks).to eq [{name: 'Task 1'}, {name: 'Task 2'}]
  end
end