require "./test_lib.rb"
require "colorize"

if ARGV == ["-v"]
  verbose = true
else
  verbose = false
end

f = File.open("./data.txt", "r")
data = f.read
data = data.split("\n")

non, top, bot, ful = [], [], [], []
data.each do |i|
  i = i.split(":")
  rt, rb = i[1], i[2]
  if (rt=="P" and rb=="P")
    ful += [i[0]]
  elsif rt=="P"
    top += [i[0]]
  elsif rb=="P"
    bot += [i[0]]
  else
    non += [i[0]]
  end
end

total = (ful + top + bot + non).length

rat = 100.0/total
fp = (ful.length*rat).round(2)
tp = (top.length*rat).round(2)
bp = (bot.length*rat).round(2)
np = (non.length*rat).round(2)

print "\n== Results ==\n\n".bold

puts "Tested from 2 to #{total+17}".bold + " (#{total+15} results)"
puts "Full passes:".bold() + " #{ful.length} (#{fp}%)"
puts "Top-only passes:".bold() + " #{top.length} (#{tp}%)"
puts "Bottom-only passes:".bold() + " #{bot.length} (#{bp}%)"
puts "Full fails:".bold() + " #{non.length} (#{np}%)"

print "\n"

if verbose
  ful = noneIfEmptyElseJoin(ful)
  top = noneIfEmptyElseJoin(top)
  bot = noneIfEmptyElseJoin(bot)
  non = noneIfEmptyElseJoin(non)
  
  puts "Full passing numbers:".bold + " #{ful}"
  puts "Top-only numbers:".bold + " #{top}"
  puts "Bottom-only numbers:".bold + " #{bot}"
  puts "Full failing numbers:".bold + " #{non}"
  
  print "\n"
end