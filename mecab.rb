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
    end
  end
end

word_count_hash.each do |word,count|
  level = level_hash[word]
  level_count_hash[level] += count
end

sum = level_count_hash.values.inject(0) { |sum, i| sum + i }
percentage = level_count_hash.map do |key,val|
  [key , (val.to_f / sum * 100).to_i ]
end.to_h

keys = {
  # 0 => [0], # 0はいらない
  1 => [1,2,3,4,5],
  2 => [2,3,4,5],
  3 => [3,4,5],
  4 => [4,5],
  5 => [5],
}

result = Hash.new
keys.each do |level, levels|
  level_sum = levels.inject(0) do |sum, l|
    num = percentage[l]
    if num
      sum += num
    else
      sum
    end
  end
  result[level] = level_sum
end

puts result.map { |key,value| value }.join(",")

