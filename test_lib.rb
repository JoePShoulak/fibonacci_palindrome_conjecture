require "terminfo"

def fib(n) #Generate Fibonacci Numbers
  a, b = 0, 1
  (n-1).times do
    a, b = b, a+b
  end
  b
end

def residuals(n) # Generate the residual sequence (mod m)
  i = 0
  a = []
  while [a[-2], a[-1]] != [n-1, 1]
    a += [fib(i) % n]
    i += 1
  end
  a
end

def pArray2(n) # Generate the array
  a = residuals(n)
  l1, l2 = [], []
  a.length.times do |it|
    if it.even?
      l1 += [a[it]]
    else
      l2 += [a[it]]
    end
  end
  [l1, l2]
end

def check(a) # Chec if the array follows the conjecture
  l1, l2 = a[0], a[1]
  z = ((l1.length)/2)
  l1a = l1[1..(z-1)]
  l1b = l1[(z+1)..((l1.length) - 1)]
  t1 = ((l1a == l1a.reverse) and (l1b == l1b.reverse))
  t2 = (l2 == l2.reverse)

  t1 = passFail(t1)
  t2 = passFail(t2)
  
  [t1, t2]
end

def noneIfEmptyElseJoin(array)
  if array == []
    r = "None"
  else
    r = array.join(", ")
  end
  r
end

def accent(str)
  if str == "pass"
    str = str.green
  else
    str = str.red
  end
  str
end

def passFail(t)
  if t
    t = "pass"
  else
    t = "fail"
  end
  t
end

def newline()
  m = TermInfo.screen_size[1]
  print "\r" + " "*m + "\b"*m
end

def plural(word, num)
  if num != 1
    word += "s"
  end
  word
end

def leadingZeroes(num, len)
  num = num.to_s
  
  while num.length != len
    num = "0" + num
  end
  
  num
end


def conciseTime(ttime)
  ttime *= 1000000
  ttime = ttime.to_i
  
  mc = ttime % 1000
  ttime = (ttime/1000.0).to_i  
  
  ml = ttime % 1000
  ttime = (ttime/1000.0).to_i
  
  s = ttime % 60
  ttime = (ttime/60.0).to_i
  
  mn = ttime % 60
  ttime = (ttime/60.0.to_i)
  
  h  = ttime
  
  h  = leadingZeroes(h,  2)
  mn = leadingZeroes(mn, 2)
  s  = leadingZeroes(s,  2)
  ml = leadingZeroes(ml, 3)
  mc = leadingZeroes(mc, 3)
  
  conciseForm = "#{h}:#{mn}:#{s}.#{ml}.#{mc}"
end


def humanTime(ttime)
  ttime *= 1000000
  ttime = ttime.to_i
  
  mc = ttime % 1000
  ttime = (ttime/1000.0).to_i  
  
  ml = ttime % 1000
  ttime = (ttime/1000.0).to_i
  
  s = ttime % 60
  ttime = (ttime/60.0).to_i
  
  mn = ttime % 60
  ttime = (ttime/60.0.to_i)
  
  h  = ttime
  
  wordForm = ""
  if h != 0
    wordForm += h.to_s + " " + plural("hour", h) + ", "
  end
  if mn != 0
    wordForm += mn.to_s + " " + plural("minute", mn) + ", "
  end
  if s != 0
    wordForm += s.to_s + " " + plural("second", s) + ", "
  end
  if ml != 0
    wordForm += ml.to_s + " " + plural("millisecond", ml) + ", "
  end
  if mc != 0
    wordForm += mc.to_s + " " + plural("microsecond", ml) + ", "
  end
  
  if wordForm == ""
    wordForm = "Less than a microsecond"
  else
    wordForm = wordForm[0..-3]
  end    
  
  wordForm.strip
end