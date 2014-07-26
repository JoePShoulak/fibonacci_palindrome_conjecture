require "./p_test_lib.rb"

f = File.open("./p_data.txt", "r")
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

total = ful.length + top.length + bot.length + non.length

rat = 100.0/total
fp = (ful.length*rat).round(2)
tp = (top.length*rat).round(2)
bp = (bot.length*rat).round(2)
np = (non.length*rat).round(2)

print "\n== Results ==\n\n"

puts "Full passes: #{ful.length} (#{fp}%)"
puts "Top-only passes: #{top.length} (#{tp}%)"
puts "Bottom-only passes: #{bot.length} (#{bp}%)"
puts "Full fails: #{non.length} (#{np}%)"

print "\n"

puts "If you would like details on the results, enter \"Verbose\" now. Enter anything else to quit."

choice = gets.chomp!

if choice.downcase == "verbose" or choice.downcase == "v"
  ful = noneIfEmptyElseJoin(ful)
  top = noneIfEmptyElseJoin(top)
  bot = noneIfEmptyElseJoin(bot)
  non = noneIfEmptyElseJoin(non)
  
  puts "Full passing numbers: #{ful}"
  puts "Top-only numbers: #{top}"
  puts "Bottom-only numbers: #{bot}"
  puts "Full failing numbers: #{non}"
end