require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

# d = lines(filename)
# d = lines_w_spaces(filename)
# d = matrix(filename)
d = matrix_i(filename)

res1 = 0
res = 0

s = []

d.each_with_index do |l, y|
  l.each_with_index do |c, x|
    s << [x, y] if c == 0
  end
end

def neighbours(f, d)
  x = f.first
  y = f.last
  [
    [x - 1, y],
    [x + 1, y],
    [x, y - 1],
    [x, y + 1]
  ].select{|c| c.first >= 0 && c.last >= 0 && c.first < d.first.length && c.last < d.length && d[c.last][c.first] == d[f.last][f.first] + 1}
end

s.each do |st|
  q = [st]
  v = {}
  while !q.empty?
    f = q.first
    q.shift
    v[f] = true
    res1 += 1 if d[f.last][f.first] == 9
    neighbours(f, d).each do |nb|
      next if v[nb]
      v[nb] = true
      q << nb
    end
  end
end
s.each do |st|
  q = [st]
  v = {}
  while !q.empty?
    f = q.first
    q.shift
    v[f] = true
    res += 1 if d[f.last][f.first] == 9
    neighbours(f, d).each do |nb|
      v[nb] = true
      q << nb
    end
  end
end


p "Part1: #{res1}"
p "Part2: #{res}"
