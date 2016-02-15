
namespace :data do


  desc "get project sprint data from jira ticket "
  task :import_sprint_data , [:project_name, :jira_ticket] => :environment  do |t, args|

    project_name = args[:project_name]
    jira_ticket = args[:jira_ticket]
    GetSprintDataWorker.perform_async(project_name,jira_ticket)
  end
end
