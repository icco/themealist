# Import in official clean and clobber tasks
require 'rake/clean'
CLEAN.include("data.db")

desc "Launch locally"
task :default do
   exec "shotgun -s thin"
end

desc "Create local db."
task :db do
   require "sequel"

   DB = Sequel.connect(ENV['DATABASE_URL'] || "sqlite://data.db")
   DB.create_table! :meals do
      primary_key :id

      String :name
      DateTime :date

      DateTime :create_date
      DateTime :modify_date
   end 

   puts "Database built."
end

