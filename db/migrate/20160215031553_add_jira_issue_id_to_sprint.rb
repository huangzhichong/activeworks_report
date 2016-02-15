class AddJiraIssueIdToSprint < ActiveRecord::Migration
  def change
    add_column :sprints, :jira_issue_id, :string
  end
end
