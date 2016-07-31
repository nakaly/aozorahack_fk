#coding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'csv'

csv_data = CSV.read('data/difficulty.csv', headers:true)

datas = Array.new

5.times do |i|
  datas[i] = csv_data.clone.map do |data|
    data
  end
  datas[i].delete_at(0)
  datas[i].sort! do |a,b|
    index = "n#{i+1}"
    b[index].to_i <=> a[index].to_i
  end
end


get '/' do
  "Hello World!!"
end

get '/level/:id' do
  id = params['id'].to_i
  datas[id-1].map do |data|
    [data["id"],data["title"],data["first"],data["last"],data["url"],data["n1"],data["n2"],data["n3"],data["n4"],data["n5"]]
  end.to_json
end

