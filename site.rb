# An app for Remembering your meals.
# @author Nat Welch - https://github.com/icco
# NOTE: You can not execute this file. Use `shotgun` to test.

configure do
   set :sessions, true
   DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://data.db')
end

get '/' do
   erb :index, :locals => {}
end

post '/' do
   redirect '/'
end

class Entry < Sequel::Model(:entries)
end
