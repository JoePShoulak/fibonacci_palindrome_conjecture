require "./p_test_lib.rb"
require 'colorize'

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
    print "\rResults for #{i}:\n".bold
    print "  Top: #{accent(rt)}\n".bold
    print "  Bot: #{accent(rb)}\n".bold
    i += 1
  rescue Exception
    diff = i - start - 1
    print "\r" + " "*20 + "\nTesting aborted.\n".bold
    break
  end
end

f = File.open("./p_data.txt", "a")
print "\nSaving data..."
f.write(data)
print "\rData saved.    \n".bold
f.close

rat = 100.0/diff
fp = (ful.length*rat).round(log10(i))
tp = (top.length*rat).round(log10(i))
bp = (bot.length*rat).round(log10(i))
np = (non.length*rat).round(log10(i))

print "\n== Results ==\n\n".bold

puts "Arrays tested: ".bold() + diff.to_s
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
  
  puts "Full passing numbers: #{ful}"
  puts "Top-only numbers: #{top}"
  puts "Bottom-only numbers: #{bot}"
  puts "Full failing numbers: #{non}"
end