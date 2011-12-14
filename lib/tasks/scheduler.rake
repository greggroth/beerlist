desc "This task is called by the Heroku cron add-on"

task :update_menus => :environment do 
  # Update the bar menus
  include Process

  puts "starting menu update"
  Dir["#{Rails.root}/lib/bar_menus/*.rb"].each do |f| 
    puts "starting #{f}"
    pid = spawn("rails r #{f}")
    waitpid(pid, 0)
  end
  puts "finished import"
end

task :remove_old_version_informaiton do
   Version.delete_all ["created_at < ?", 1.week.ago] 
end