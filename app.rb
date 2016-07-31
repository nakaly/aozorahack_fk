#coding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'uri'

get '/' do
"Hello World!!"
end

get '/json' do
#f = open('sample.json').read
f = JsonData.new()
result = JSON.parse(f)
"#{result}"
end

class JsonData
car = "kuruma"
end
