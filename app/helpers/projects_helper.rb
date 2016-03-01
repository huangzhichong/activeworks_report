module ProjectsHelper

  def format_summary_of_tasks(summary)
    temp = []
    summary.each do |k,v|
      v = 0 if v.nil?
      temp << {"name" => k, "y"=>v, "hour" => (v.to_f/3600)}
    end
    temp.to_json
  end

  def short_summary_text(summary)
    (summary.length > 90) ? "#{summary.slice(0..86)}..." : summary
  end

end
