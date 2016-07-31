#!/usr/bin/env ruby
# coding: utf-8
require 'natto'
require 'csv'

nm = Natto::MeCab.new('-F%f[6],%f[0],%f[1]')

dic = CSV.read(ARGV[0])

level_hash = Hash.new
word_count_hash = Hash.new(0)
dic.each do |level,word|
  level_hash[word] = level.to_i
end
level_count_hash = Hash.new(0)

arr = Array.new

while line = STDIN.gets
  nm.enum_parse(line).reject do |n|
    n.is_eos?
  end.map do |n|
    n.feature.split(",")
  end.select do |word, a, b|
    word != '' && ( ( a == '名詞' && b != '固有名詞')|| a == '動詞' ) 
  end.each do |word, a, b|
    if level = level_hash[word]
      word_count_hash[word] += 1
    else
      level_count_hash[0] += 1
      arr << word + ":" + b
    end
  end
end

word_count_hash.each do |word,count|
  level = level_hash[word]
  level_count_hash[level] += count
end
p "level_count"
p level_count_hash

# 実行環境
# gem install natto
#
# 実行例
# echo 今日は雪が降ってて非常に寒い。おなか減った。| ruby mecab.rb test.csv
