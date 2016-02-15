module ProjectsHelper

  def format_summary_of_tasks(summary)
    temp = []
    summary.each do |k,v|
      temp << {"name" => k, "y"=>v}
    end
    temp.to_json
  end

  def short_summary_text(summary)
    (summary.length > 50) ? "#{summary.slice(0..46)}..." : summary
  end

end
