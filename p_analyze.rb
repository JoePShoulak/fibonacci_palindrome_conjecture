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

if ful == []
  ful = "None" 
else
  ful.join(", ")
end
if top == []
  top = "None"
else
  top.join(", ")
end
if bot == []
  bot = "None"
else
  bot.join(", ")
end
if non == []
  non = "None"
else
  non.join(", ")
end

puts "Full passing numbers: #{ful}"
puts "Top-only numbers:     #{top}"
puts "Bottom-only numbers:  #{bot}"
puts "Full failing numbers: #{non}"