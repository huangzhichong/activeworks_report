class JIRAAPIClient

  JIRA_BASE_API_URL = "https://jirafnd.dev.activenetwork.com/rest/api/2"

  def initialize(user_name,password)
    @user_name = user_name
    @password = password
  end


  def get_open_automation_tasks
    query_string = "search?jql=project%20in%20(FNDCAMP%2CFNDSWIM%2C%20CUI%2C%20COMMERCE%2CENDR%2C%20MEMB)%20and%20type%20%3D%20%22Automation%20Task%22%20and%20summary%20~%20%22Automation%20Task%20in%25%22%20and%20status%20%3D%20Open"
    result = jira_api_call_get("#{JIRA_BASE_API_URL}/#{query_string}")
    result['issues'].map{|t| t['key']}
  end


  def get_automation_subtasks_by_issue(issue)
    data = {"jql" => "key = #{issue}","fields" => ["id","key","subtasks"]}
    result = jira_api_call_post("#{JIRA_BASE_API_URL}/search",data)
    result["issues"][0]['fields']['subtasks'].map{|i| i['key']}
  end



  def get_automation_task_info(issue)
    data = {"jql" => "key = #{issue}","fields" => ['description','summary','fixVersions']}
    result = jira_api_call_post("#{JIRA_BASE_API_URL}/search", data)
    {
      "summary" => result["issues"][0]['fields']['summary'],
      "description" => result["issues"][0]['fields']['description'],
    }
  end

  def get_automation_subtask_info(issue)
    data = {"jql" => "key = #{issue}","fields" => ['customfield_15056','summary','timespent','assignee','status','timeoriginalestimate']}
    result = jira_api_call_post("#{JIRA_BASE_API_URL}/search", data)
    {
      "assignee" => result["issues"][0]['fields']['assignee']['displayName'],
      "summary" => result["issues"][0]['fields']['summary'],
      "number_of_test_case" => result["issues"][0]['fields']['customfield_15056'],
      "spent_time" => result["issues"][0]['fields']['timespent'],
      "estimated_time" => result["issues"][0]['fields']['timeoriginalestimate'],
      "status" => result["issues"][0]['fields']['status']['name']
    }
  end

  def get_work_log_by_issue(issue)
    query_string = "issue/#{issue}/worklog"
    result = jira_api_call_get("#{JIRA_BASE_API_URL}/#{query_string}")
    temp = {}
    result['worklogs'].each do |w|
      author = w['author']['displayName']
      spent_time = w['timeSpentSeconds']
      temp[author] ||= 0
      temp[author] += spent_time
    end
    temp
  end

  # return a JSON including issue items
  def jira_api_call_get(url)
    resource = RestClient::Resource.new(url, @user_name, @password)
    JSON.parse(resource.get)
  end

  def jira_api_call_post(url,data,header = {"Content-Type" => "application/json"})
    resource = RestClient::Resource.new(url, @user_name, @password)
    JSON.parse(resource.post data.to_json, header)
  end

  def get_task_type_by_summary(summary)
    e = /^(Script Maintenance|Full Regression|Regression|Automation|Framework|Meeting|MISC|Code Review|Test Case Review)/
    t = summary.match e
    unless t.nil?
      result = t[0]
      result = 'Regression' if result =='Full Regression'
      return result
    else
      return nil
    end
  end

end

