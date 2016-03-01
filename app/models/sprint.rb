class Sprint < ActiveRecord::Base
  belongs_to :project
  has_many :tasks
  validates_uniqueness_of :name, :scope => :project_id

  def total_hours
    self.tasks.sum(:spent_time)
  end
  def summary_of_tasks
    summary =  Hash.new
    TaskType.all.each do |task|
      spent_time = self.tasks.where(:task_type_id=>task.id).map(&:spent_time).sum
      summary[task.name] = spent_time unless spent_time == 0
    end
    summary
  end

  def summary_of_automation_tasks
    summary =  Hash.new
    automation_task = TaskType.find_by_name("Automation")
    self.tasks.where(:task_type_id=>automation_task.id).each do |t|
      summary[t.assignee] ||= {}
      summary[t.assignee]['spent_time'] ||= 0
      summary[t.assignee]['number_of_test_case'] ||= 0
      unless t.spent_time.nil?
        summary[t.assignee]['spent_time'] += t.spent_time
      end
      unless t.number_of_test_case.nil?
        summary[t.assignee]['number_of_test_case'] += t.number_of_test_case
      end
    end
    summary
  end

end
