#require 'fog'

desc "Tell us how much space is in use on S3"
  namespace :s3 do
   task usage: :environment do
     size = 0

     connection = Fog::Storage.new(
       provider:               'AWS',
       aws_access_key_id:      ENV['S3_KEY'],
       aws_secret_access_key:  ENV['S3_SECRET'],
       region:                 'us-east-1'
     )

     connection.directories.each do |directory|
       directory.files.each do |file|
         size += file.content_length
       end
     end

     # puts "#{size / 1073741824} GB"
     puts "#{size} Bytes"
   end
end