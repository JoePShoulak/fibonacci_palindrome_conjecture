require "./p_test_lib.rb"

if ARGV.length != 1
  l, h = ARGV[0].to_i, ARGV[1].to_i
  non, top, bot, ful = [], [], [], []

  (l..h).each do |i|
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
      print "\rResults for #{i}:\n"
      print "  Top: #{rt}\n"
      print "  Bot: #{rb}\n"
    rescue Exception
      h = i
      print "\rTesting aborted.\n"
      break
    end
  end
  
  rat = 100.0/(h-l+1)
  fp = (ful.length*rat).round(log10(h))
  tp = (top.length*rat).round(log10(h))
  bp = (bot.length*rat).round(log10(h))
  np = (non.length*rat).round(log10(h))
  
  print "\n== Results ==\n\n"

  puts "Full passes: #{ful.length} (#{fp}%)"
  puts "Top-only passes: #{top.length} (#{tp}%)"
  puts "Bottom-only passes: #{bot.length} (#{bp}%)"
  puts "Full fails: #{non.length} (#{np}%)"
  
  print "\n"

  puts "If you would like details on the results, enter \"Verbose\" now. Enter anything else to quit."

  choice = $stdin.gets.chomp!
  
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
else
  to_test = ARGV[0]
  print "Testing #{to_test}..."
  a = pArray2(to_test.to_i)
  r = check(a)
  rt, rb = r[0], r[1]
  print "\rResults for #{to_test}:\n"
  print "  Top: #{rt}\n"
  print "  Bot: #{rb}\n"

  puts "If you would like to view the array, enter \"Verbose\" now. Enter anything else to quit."

  choice = $stdin.gets.chomp!
  if choice.downcase == "verbose" or choice.downcase == "v"
    p a[0]
    p a[1]
  end
end
