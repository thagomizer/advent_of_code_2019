low, high = File.read(ARGV[0]).split("-").map(&:to_i)

data = (low..high).map { |n| n.to_s.split('').map(&:to_i) }

count = data.count { |digits|
  digits.each_cons(2).all?{ |x, y| x <= y } &&
    digits.each_cons(2).any?{ |x, y| x == y }
}

puts "Star 1 #{count}"

count = data.count { |digits|
  digits.each_cons(2).all?{ |x, y| x <= y } &&
    digits.group_by { |n| n }.values.any? { |a| a.length == 2 }
}

puts "Star 2 #{count}"
