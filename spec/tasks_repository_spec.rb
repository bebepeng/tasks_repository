require 'rspec'
require 'tasks_repository'

describe TasksRepository do
  before do
    db = Sequel.connect('postgres://gschool_user:gschool_user@localhost:5432/tasks_database')
    db.create_table! :tasks_list do
      primary_key :id
      String :name
      boolean :completed
    end
    tasks = db[:tasks_list]
    @list_of_tasks = TasksRepository.new(tasks)
    @list_of_tasks.add('Task 1')
    @list_of_tasks.add('Task 2')
  end

  it "adds task items to a database" do
    @list_of_tasks.add('Task 3')
    expect(@list_of_tasks.list_all).to eq [{id: 1, name: 'Task 1', completed: false},
                                          {id: 2, name: 'Task 2', completed: false},
                                          {id: 3, name: 'Task 3', completed: false}]
  end

  it "deletes task itmes in a database" do
    @list_of_tasks.delete('Task 1')
    expect(@list_of_tasks.list_all).to eq [{id: 2, name: 'Task 2', completed: false}]
  end

  it "edits task itmes in a database" do
    @list_of_tasks.edit('Task 1', {:name => 'Task new', :completed => true})
    @list_of_tasks.edit('Task 2', {:completed => true})
    expect(@list_of_tasks.list_all).to eq [{id: 1, name: 'Task new', completed: true},
                                          {id: 2, name: 'Task 2', completed: true}]
  end

  it "searches tasks items by id" do
    expect(@list_of_tasks.list(2)).to eq [{id: 2, name: 'Task 2', completed: false}]
  end

  it "prints all the tasks" do
    expect(@list_of_tasks.list_tasks).to eq [{name: 'Task 1'}, {name: 'Task 2'}]
  end
end