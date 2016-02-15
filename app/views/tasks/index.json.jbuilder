json.array!(@tasks) do |task|
  json.extract! task, :id, :summary, :assignee, :jira_ticket, :status, :estimated_time, :spent_time, :number_of_test_case, :task_type_id
  json.url task_url(task, format: :json)
end
