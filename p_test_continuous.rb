require "./p_test_lib.rb"

f = File.open("./p_data.txt", "r")
start = f.read.split("\n")[-1].split(":")[0].to_i
f.close

data = ""

non, top, bot, ful = [], [], [], []

i = start + 1
while 1 == 1
  begin
    print "Testing #{i}..."
    r = check(pArray2(i))
    rt, rb = r[0], r[1]
    if (rt=="pass" and rb=="pass")
      ful += [i]
    elsif rt=="pass"
      top += [i]
    elsif rb=="pass"
      bot += [i]
    else
      non += [i]
    end
    data += "#{i}:#{rt.upcase[0]}:#{rb.upcase[0]}\n"
    print "\rResults for #{i}:\n"
    print "  Top: #{rt}\n"
    print "  Bot: #{rb}\n"
    i += 1
  rescue Exception
    diff = i - start
    print "\rTesting aborted.\n"
    break
  end
end

f = File.open("./p_data.txt", "a")
f.write(data)
f.close

rat = 100.0/diff
fp = (ful.length*rat).round(log10(i))
tp = (top.length*rat).round(log10(i))
bp = (bot.length*rat).round(log10(i))
np = (non.length*rat).round(log10(i))

print "\n== Results ==\n\n"

puts "Full passes: #{ful.length} (#{fp}%)"
puts "Top-only passes: #{top.length} (#{tp}%)"
puts "Bottom-only passes: #{bot.length} (#{bp}%)"
puts "Full fails: #{non.length} (#{np}%)"

print "\n"

puts "If you would like details on the results, enter \"Verbose\" now. Enter anything else to quit."

choice = gets.chomp!

if choice.downcase == "verbose" or choice.downcase == "v"
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
end