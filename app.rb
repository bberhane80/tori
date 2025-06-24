require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"

ITEMS = [
  { name: "Burger", unit: "patties" },
  { name: "Fries", unit: "lbs" },
  { name: "Soda", unit: "liters" }
]

get('/') do
  erb(:index)
end

post('/calculate') do
  @projection = params[:projection].to_f / 100
  @results = ITEMS.map do |item|
    key = item[:name].downcase
    {
      name: item[:name],
      normal: params[key].to_i,
      needed: (params[key].to_i * @projection).round,
      unit: item[:unit]
    }
  end
  erb(:results)
end
