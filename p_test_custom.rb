require "./p_test_lib.rb"
require "colorize"

if ARGV[-1] == "-v"
  args = ARGV[0, ARGV.length-1]
  verbose = true
else
  args = ARGV
  verbose = false
end

if args.length != 1
  l, h = args[0].to_i, args[1].to_i
  non, top, bot, ful = [], [], [], []

  (l..h).each do |i|
    begin
      print "Testing #{i}" + "...".blink
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
      newline
      puts "Results for #{i}:".bold
      puts "  Top: #{accent(rt)}".bold
      puts "  Bot: #{accent(rb)}".bold
    rescue Exception
      h = i
      print "\r" + " "*20 + "\nTesting aborted.\n".bold
      break
    end
  end
  
  rat = 100.0/(h-l+1)
  fp = (ful.length*rat).round(2)
  tp = (top.length*rat).round(2)
  bp = (bot.length*rat).round(2)
  np = (non.length*rat).round(2)
  
  print "\n== Results ==\n\n".bold

  puts "Tested from #{l} to #{h}".bold + " (#{h-l} arrays)"
  puts "Full passes: #{ful.length}".bold + " (#{fp}%)"
  puts "Top-only passes: #{top.length}".bold + " (#{tp}%)"
  puts "Bottom-only passes: #{bot.length}".bold + " (#{bp}%)"
  puts "Full fails: #{non.length}".bold + " (#{np}%)"
  
  print "\n"
  
  if verbose
    ful = noneIfEmptyElseJoin(ful)
    top = noneIfEmptyElseJoin(top)
    bot = noneIfEmptyElseJoin(bot)
    non = noneIfEmptyElseJoin(non)
    
    puts "Full passing numbers: ".bold + "#{ful}"
    puts "Top-only numbers: ".bold + "#{top}"
    puts "Bottom-only numbers: ".bold + "#{bot}"
    puts "Full failing numbers: ".bold + "#{non}"
  end
else
  to_test = args[0]
  print "Testing #{to_test}" + "...".blink
  a = pArray2(to_test.to_i)
  r = check(a)
  rt, rb = r[0], r[1]
  newline
  puts "Results for #{to_test}:".bold
  puts "  Top: #{accent(rt)}".bold
  puts "  Bot: #{accent(rb)}".bold

  if verbose
    p a[0]
    p a[1]
  end
end
