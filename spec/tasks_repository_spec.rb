require 'rspec'
require 'tasks_repository'

describe TasksRepository do
  it "creates task items in a database" do
    list_of_tasks = TasksRepository.new
    list_of_tasks.add('Task 1', 3)
    list_of_tasks.add('Task 2', 2)
    list_of_tasks.add('Task 3', 1)
    expect(list_of_tasks.list_all).to eq [{id: 1,name:'Task 1',priority: 3},
                                          {id: 2,name:'Task 2',priority: 2},
                                         {id: 3,name:'Task 3',priority: 1}]
    end
end




















#require 'tasks_repository'
#require 'rspec'
#
#db = Sequel.connect("postgres://gschool_user:password@localhost:5432/tasks_test")
#
#describe TasksRepository do
#
#
#  before do
#    db.create_table! :tasks do
#      primary_key :id
#      String :description
#      Boolean :completed, default: false
#    end
#  end
#
#  it "can create tasks" do
#
#    repository = TasksRepository.new(db)
#
#    description = "Do #{rand(2..20)} things"
#    repository.create(description: description)
#    tasks = repository.all
#    expect(tasks).to eq(
#
#      {id: 1, description: description, completed: false}
#                      )
#  end
#end