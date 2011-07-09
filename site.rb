# An app for Remembering your meals.
# @author Nat Welch - https://github.com/icco
# NOTE: You can not execute this file. Use `shotgun` to test.

configure do
   set :sessions, true
   DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://data.db')
end

get '/' do
   erb :index, :locals => { :meals => Meal.all }
end

post '/' do
   m = Meal.new
   m.name = params["meal"]
   m.date = params["date"] if !params["date"].nil?
   m.save

   redirect '/'
end

get '/meal/:id' do
   meal = Meal.find(params["id"])

   # TODO: doesn't work because Meal.find returns a meal, no matter what.
   if !meal.nil?
      erb :meal, :locals => { :meal => meal }
   else
      p params
      error "404"
   end
end

class Meal < Sequel::Model(:meals)
end
