require "sinatra"
require "sinatra/reloader"
require "http"
require "json" 

get("/") do

  api_url = "https://api.freecurrencyapi.com/v1/currencies?apikey=#{ENV['FREE_CURRENCY_API_KEY']}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data)
  @symbols = parsed_data.fetch("data").keys

  # render a view template where I show the symbols
   erb(:homepage)
end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  api_url = "https://api.freecurrencyapi.com/v1/currencies?apikey=#{ENV['FREE_CURRENCY_API_KEY']}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data)
  @symbols = parsed_data.fetch("data").keys

  erb(:from_currency) 
   
end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
    @destination_currency = params.fetch("to_currency")

  api_url = "https://api.freecurrencyapi.com/v1/latest?apikey=#{ENV['FREE_CURRENCY_API_KEY']}&currencies=#{@original_currency}%2C#{@destination_currency}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data)
  
  @result = parsed_data.fetch("data").fetch(@destination_currency).to_f

  erb(:to_currency) 
  
end
