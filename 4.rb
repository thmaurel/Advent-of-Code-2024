require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

d = File.open("data_#{day}.txt").read.split("\n").map{|x| x.split('')} #.map{|x| x.split(' ').map(&:to_i)}

# p d

res = 0
res1 = 0

# M.S
# .A.
# M.S

d.each_with_index do |l, y|
  l.each_with_index do |c, x|
    if c == 'A'
      if l[x+1] && x>0 && d[y+1] && d[y+1][x+1] && y>0 && [d[y-1][x-1], d[y-1][x+1], d[y+1][x-1], d[y+1][x+1]].sort == ['M', 'M', 'S', 'S'] && d[y-1][x-1] !=  d[y+1][x+1]
        res += 1
      end
    end

    # Part 1
    if c == 'X'
      if  l[x + 1] && l[x + 2] && l[x + 3] && l[x + 1] == 'M' && l[x+2] == 'A' && l[x+3] == 'S'
        res1 += 1
      end
      if  x - 3 >= 0 && l[x - 1] == 'M' && l[x-2] == 'A' && l[x-3] == 'S'
        res1 += 1
      end
      if  d[y+1] && d[y+2] && d[y+3] && d[y+1][x + 1] && d[y+2][x + 2] && d[y+3][x + 3] && d[y+1][x + 1] == 'M' && d[y+2][x+2] == 'A' && d[y+3][x+3] == 'S'
        res1 += 1
      end
      if d[y+1] && d[y+2] && d[y+3] && x >= 3 && d[y+1][x - 1] == 'M' && d[y+2][x-2] == 'A' && d[y+3][x-3] == 'S'
        res1 += 1
      end
      if y >= 3 && x >= 3 && d[y-1][x - 1] == 'M' && d[y-2][x-2] == 'A' && d[y-3][x-3] == 'S'
        res1 += 1
      end
      if y >= 3 && d[y-1][x + 1] && d[y-2][x + 2] && d[y-3][x + 3] && d[y-1][x + 1] == 'M' && d[y-2][x+2] == 'A' && d[y-3][x+3] == 'S'
        res1 += 1
      end
      if y >= 3 && d[y-1][x] == 'M' && d[y-2][x] == 'A' && d[y-3][x] == 'S'
        res1 += 1
      end
      if d[y+1] && d[y+2] && d[y+3] && d[y+1][x] == 'M' && d[y+2][x] == 'A' && d[y+3][x] == 'S'
        res1 += 1
      end
    end
  end
end

p res1
p res
