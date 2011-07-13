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

get '/build' do
   m = Meal.new
   m.name = "Dinner Tuesday"
   m.save

   i = Item.new
   i.name = "Pasta"
   i.meal = m
   i.save
   i = Item.new
   i.name = "Pasta sauce"
   i.depth = 1
   i.meal = m
   i.save
   i = Item.new
   i.name = "angel hair pasta"
   i.depth = 1
   i.meal = m
   i.save
   i = Item.new
   i.name = "cheese"
   i.depth = 1
   i.meal = m
   i.save

   i = Item.new
   i.name = "red wine"
   i.depth = 0
   i.meal = m
   i.save

   redirect '/'
end

post '/' do
   m = Meal.new
   m.name = params["meal"]
   m.date = params["date"] if !params["date"].nil?
   m.save

   (0..5).each do |idx|
      i = Item.new
      i.meal = m
      i.name = "blah #{idx}"
      i.save
   end

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
   one_to_many :items
end

class Item < Sequel::Model(:items)
   many_to_one :meal
end
