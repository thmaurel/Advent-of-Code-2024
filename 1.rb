require_relative 'lib'

day = 1
year = 2024
get_datas(day, year)

d = File.open("data_#{day}.txt").read.split("\n")

l1 = []
l2 = []
d.each do |l|
  l1 << l.split(' ').first.to_i
  l2 << l.split(' ').last.to_i
end

res = 0

l1.each do |c|
  res += c * l2.count(c)
end

p res
return

# part 1

l1 = l1.sort!
l2 = l2.sort!

l1.each_with_index do |c, i|
  res += (c - l2[i]).abs
end

p res
