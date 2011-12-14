# #  Update by running "whenever --update-crontab load_menus"
# 
# job_type :ruby_run, "cd :path && ruby :task :output"
# set :output, "#{path}/log/cron.log"
# 
# # Updates the beer menus by running every ruby file in ./app/lib_imports
# every :tuesday, :at => '2:28 pm' do
#   ruby_run "./app/lib/import_all_menus.rb"
# end
