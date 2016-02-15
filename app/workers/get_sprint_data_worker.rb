require 'jira_api_client'


class GetSprintDataWorker
  include Sidekiq::Worker

  #post order and order payment info
  def perform(project_name, jira_issue)

    user = ENV["JIRAUserName"]
    password = ENV["JIRAUserPassword"]
    jira = JIRAAPIClient.new(user,password)


    project = Project.find_by_name(project_name)

    if project
      begin
        task = jira.get_automation_task_info(jira_issue)
        sprint = task['summary'].split('Automation Task in').last.strip
        start_date = task['description'].match(/#START DATE# \d{4}-\d{1,2}-\d{1,2}/).to_s.split("DATE#").last.strip
        end_date = task['description'].match(/#END DATE# \d{4}-\d{1,2}-\d{1,2}/).to_s.split("DATE#").last.strip

        s = project.sprints.where(:name => sprint).first_or_initialize
        s.start_date = start_date
        s.end_date = end_date
        s.jira_issue_id = jira_issue
        s.save

        subtasks = jira.get_automation_subtasks_by_issue(jira_issue)
        subtasks.each_with_index do |sub,i|

          t = s.tasks.where(:jira_ticket => sub).first_or_initialize
          sub_info = jira.get_automation_subtask_info(sub)
          task_type = jira.get_task_type_by_summary(sub_info['summary'])

          tt = TaskType.find_by_name(task_type)
          if tt
            t.summary = sub_info['summary']
            t.assignee = sub_info['assignee']
            t.status = sub_info['status']
            t.estimated_time = sub_info['estimated_time']
            t.spent_time= sub_info['spent_time']
            t.number_of_test_case= sub_info['number_of_test_case']
            t.task_type_id =tt.id
            t.save
          end
        end
      rescue Exception => e
        puts "error in geting report of #{jira_issue} \n#{e}"
      end
    end
  end


end
