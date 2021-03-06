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
   m.date = Chronic.parse(params["date"]) if !params["date"].nil?
   m.save

   redirect '/'
end

get '/meal/:id' do
   meal = Meal[params["id"]]

   if !meal.nil?
      erb :meal, :locals => { :meal => meal }
   else
      error "404"
   end
end

class Meal < Sequel::Model(:meals)
   one_to_many :items
end

class Item < Sequel::Model(:items)
   many_to_one :meal
end
class Time
   def time_since
      dist = Time.now - self
      distance = dist.abs
      post_sentence = dist < 0 ? "" : " ago"

      out = case distance
            when 0 .. 59 then "#{distance} seconds"
            when 60 .. (60*60) then "#{distance/60} minutes"
            when (60*60) .. (60*60*24) then "#{distance/(60*60)} hours"
            when (60*60*24) .. (60*60*24*30) then "#{distance/((60*60)*24)} days"
            else self.to_s
            end

      return out.sub(/^1 (\w+)s ago$/, '1 \1 ago')
   end
end
