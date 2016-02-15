class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :summary
      t.string :assignee
      t.string :jira_ticket
      t.string :status
      t.integer :estimated_time
      t.integer :spent_time
      t.integer :number_of_test_case
      t.integer :task_type_id

      t.timestamps null: false
    end
  end
end
