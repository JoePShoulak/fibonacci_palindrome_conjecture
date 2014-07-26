require "./p_test_lib.rb"
require "colorize"

if ARGV[-1] == "-v"
  args = ARGV[0, ARGV.length-1]
  verbose = true
else
  args = ARGV
end

if args.length != 1
  l, h = args[0].to_i, args[1].to_i
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
      print "\rResults for #{i}:\n".bold
      print "  Top: #{accent(rt)}\n".bold
      print "  Bot: #{accent(rb)}\n".bold
    rescue Exception
      h = i
      print "\r" + " "*20 + "\nTesting aborted.\n".bold
      break
    end
  end
  
  rat = 100.0/(h-l+1)
  fp = (ful.length*rat).round(log10(h))
  tp = (top.length*rat).round(log10(h))
  bp = (bot.length*rat).round(log10(h))
  np = (non.length*rat).round(log10(h))
  
  print "\n== Results ==\n\n".bold

  puts "Full passes: #{ful.length} (#{fp}%)".bold
  puts "Top-only passes: #{top.length} (#{tp}%)".bold
  puts "Bottom-only passes: #{bot.length} (#{bp}%)".bold
  puts "Full fails: #{non.length} (#{np}%)".bold
  
  print "\n"
  
  if verbose
    ful = noneIfEmptyElseJoin(ful)
    top = noneIfEmptyElseJoin(top)
    bot = noneIfEmptyElseJoin(bot)
    non = noneIfEmptyElseJoin(non)
    
    puts "Full passing numbers:".bold() + " #{ful}"
    puts "Top-only numbers:".bold() + " #{top}"
    puts "Bottom-only numbers:".bold() + " #{bot}"
    puts "Full failing numbers:".bold() + " #{non}"
  end
else
  to_test = args[0]
  print "Testing #{to_test}..."
  a = pArray2(to_test.to_i)
  r = check(a)
  rt, rb = r[0], r[1]
  print "\rResults for #{to_test}:\n".bold
  print "  Top: #{accent(rt)}\n".bold
  print "  Bot: #{accent(rb)}\n".bold

  if verbose
    p a[0]
    p a[1]
  end
end
