namespace :reddit do
  desc "Calls RedditAPIRunner.scan_new to find goals in 50 newest /r/soccer posts"
  task :scan_new => :environment do
    initial_records = Highlight.all.length
    RedditAPIRunner.scan_new
    final_records = Highlight.all.length
    log_text = <<~HEREDOC
    *#{DateTime.now} | RedditAPIController.scan_new completed successfully
      #{final_records - initial_records} records added to highlights table
    HEREDOC
    puts log_text
  end
end
