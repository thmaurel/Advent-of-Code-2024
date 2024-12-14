# Part 1 requires a 100.times do
# Part 2 just display everysingle step with a specific pattern,
# you need to figure the frequence of specific pattern, here (i - 22) % 101 == 0
# until you get the tree, just scroll the terminal x)

require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

d = lines(filename)
# d = lines_w_spaces(filename)
# d = matrix(filename)
# d = matrix_i(filename)

rbs = []

x = 101
y = 103

d.each do |l|
  px = l.split(',').first.split('=').last.to_i
  py = l.split(' v').first.split(',').last.to_i
  vx = l.split(' v=').last.split(',').first.to_i
  vy = l.split(',').last.to_i
  rbs << {pos: [px, py], v: [vx, vy]}
end

# Part 1 with 100.times
100000.times do |i|

  nex = []
  rbs.each do |rb|
    npx = (rb[:pos].first + rb[:v].first) % x
    npy = (rb[:pos].last + rb[:v].last) % y
    nex << {pos: [npx, npy], v: rb[:v]}
  end
  rbs = nex

  # this is my input pattern, not sure it's everyone's
  if (i - 22) % 101 == 0

    puts "After #{i + 1}s"
    y.times do |j|
      x.times do |i|
        if rbs.map{|x| x[:pos]}.include?([i,j])
          print 'X'
        else
          print '.'
        end
      end
      print "\n"
    end
    puts "-----------------------------------------"
  end
end

nw = 0
ne = 0
sw = 0
se = 0

rbs.each do |rb|
  xi = rb[:pos].first
  yi = rb[:pos].last

  if xi < x / 2 && yi < y / 2
    nw += 1
  elsif xi < x/2 && yi > y/2
    sw += 1
  elsif xi > x/2 && yi < y/2
    ne += 1
  elsif xi > x/2 && yi > y/2
    se += 1
  end
end

res = nw * ne * se * sw

p res
