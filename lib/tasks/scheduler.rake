task :goal_reminder => :environment do
  #Goal.cron_job
  @goal = Goal.all
  @goal.each do |g|
  UserNotifier.send_goal_email(g.user).deliver!
end
