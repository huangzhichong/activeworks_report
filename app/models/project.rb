class Project < ActiveRecord::Base
  has_many :sprints

  def sprint_scheduled_tasks(sprint_name)
    sprints.where(:name => sprint_name).first.tasks
  end

  def sprint_tasks_summary(sprint_name)
    sprints.where(:name => sprint_name).first.calculate_summary
  end



end
