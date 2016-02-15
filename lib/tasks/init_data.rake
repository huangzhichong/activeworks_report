namespace :init do

  desc "Init some user and project data"
  task :insert_data => :environment do

    TaskType.delete_all
    Task.delete_all
    Sprint.delete_all
    Project.delete_all

    Project.create(:name => "Camps").save
    Project.create(:name => "Endurance").save
    Project.create(:name => "Membership").save
    Project.create(:name => "Swimming").save
    Project.create(:name => "Commerce").save
    Project.create(:name => "CUI").save

    TaskType.create(:name => 'Script Maintenance').save
    TaskType.create(:name => 'Regression').save
    TaskType.create(:name => 'Automation').save
    TaskType.create(:name => 'Framework').save
    TaskType.create(:name => 'Meeting').save
    TaskType.create(:name => 'MISC').save
    TaskType.create(:name => 'Code Review').save
    TaskType.create(:name => 'Test Case Review').save



    GetSprintDataWorker.perform_async("Endurance","ENDR-23539")
    GetSprintDataWorker.perform_async("Endurance","ENDR-23930")
    GetSprintDataWorker.perform_async("Endurance","ENDR-24280")

    GetSprintDataWorker.perform_async("Camps","FNDCAMP-25020")
    GetSprintDataWorker.perform_async("Camps","FNDCAMP-25264")
    GetSprintDataWorker.perform_async("Camps","FNDCAMP-25445")

  end
end
