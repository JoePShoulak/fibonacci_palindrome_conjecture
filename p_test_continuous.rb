require "./p_test_lib.rb"
require "colorize"

if ARGV == ["-v"]
  verbose = true
else
  verbose = false
end

f = File.open("./p_data.txt", "r")
start = f.read.split("\n")[-1].split(":")[0].to_i
f.close

data = ""

non, top, bot, ful = [], [], [], []

i = start + 1
while 1 == 1
  begin
    print "Testing #{i}" + "...".blink
    ttime = Time.now
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
    newline
    puts "Results for #{i}:".bold
    puts "  Top: #{accent(rt)}".bold
    puts "  Bot: #{accent(rb)}".bold
    puts "  Time: #{humanTime(Time.now - ttime)}".bold
    i += 1
  rescue Interrupt
    finish = i - 1 
    diff = finish - start
    print "\r" + " "*20 + "\nTesting aborted.\n".bold
    break
  end
end

f = File.open("./p_data.txt", "a")
print "\nSaving data..."
f.write(data)
newline
puts "Data saved.".bold
f.close

rat = 100.0/diff
fp = (ful.length*rat).round(2)
tp = (top.length*rat).round(2)
bp = (bot.length*rat).round(2)
np = (non.length*rat).round(2)

puts "\n== Results ==\n".bold

puts "Tested from #{start} to #{finish}".bold + " (#{finish-start} arrays)"
puts "Full passes: #{ful.length} ".bold + "(#{fp}%)"
puts "Top-only passes: #{top.length} ".bold + "(#{tp}%)"
puts "Bottom-only passes: #{bot.length} ".bold + "(#{bp}%)"
puts "Full fails: #{non.length} ".bold + "(#{np}%)"

print "\n"

if verbose
  ful = noneIfEmptyElseJoin(ful)
  top = noneIfEmptyElseJoin(top)
  bot = noneIfEmptyElseJoin(bot)
  non = noneIfEmptyElseJoin(non)
  
  puts "Full passing numbers: #{ful}"
  puts "Top-only numbers: #{top}"
  puts "Bottom-only numbers: #{bot}"
  puts "Full failing numbers: #{non}"
end