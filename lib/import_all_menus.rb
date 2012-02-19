include Process
require "nokogiri"
require "open-uri"
require "yaml"
require "enumerator"
require "active_support"

Dir['app/lib/bar_menus/*.rb'].each do |f| 
  puts "starting #{f}"
  pid = spawn("rails r #{f}")
  waitpid(pid, 0)
end
ActionController::Base.new.expire_fragment("top_deals")
puts "finished import"