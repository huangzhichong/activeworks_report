json.array!(@sprints) do |sprint|
  json.extract! sprint, :id, :name, :project_id
  json.url sprint_url(sprint, format: :json)
end
