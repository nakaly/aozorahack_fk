#!/usr/bin/env ruby
# coding: utf-8

KISAI = /^-{5,}/
MATSUBI_START = /^底本：/

kisai_count = 0
while line = STDIN.gets
  if kisai_count != 2
    if line =~ KISAI
      kisai_count += 1
    end
    next
  else
    if line =~ MATSUBI_START
      break
    end
    puts line
  end

end
