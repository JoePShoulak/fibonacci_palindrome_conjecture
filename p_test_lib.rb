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

def pArray2(n) # Generate the array TODO: Chance to general pisano array, pass "2" to it later
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
  if t1
    t1 = "pass"
  else
    t1 = "fail"
  end
  if t2
    t2 = "pass"
  else
    t2 = "fail"
  end
  [t1, t2]
end

def log10(x) # Log base 10
  Math.log(x)/Math.log(10)
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