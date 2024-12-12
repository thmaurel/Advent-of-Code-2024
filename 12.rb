require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

# d = lines(filename)
# d = lines_w_spaces(filename)
d = matrix(filename)
# d = matrix_i(filename)

def nbs_no_diag(x, y, d)
  [
    [x - 1, y],
    [x + 1, y],
    [x, y - 1],
    [x, y + 1]
  ].select{|c| c.first >= 0 && c.last >= 0 && c.first < d.first.length && c.last < d.length }
end

res = 0
res1 = 0

rs = []

v = {}
d.each_with_index do |l, y|
l.each_with_index do |c, x|
  next if v[[x, y]]

  s = [x, y]
  v[s] = true
  q = [s]
  ar = [s]
  while !q.empty?
    f = q.shift
    nbs_no_diag(f.first, f.last, d).each do |nb|
      next if v[nb]

      if d[nb.last][nb.first] == c
        ar << nb
        q << nb
        v[nb] = true
      end
    end
  end
  rs << ar
end
end

def nbs_no_diag2(x, y, d)
  [
    [x - 1, y],
    [x + 1, y],
    [x, y - 1],
    [x, y + 1]
  ]
end

rs.each do |r|
  tmp1 = 0
  area = r.length
  sds = []

  r.each do |rc|
    nbs_no_diag2(rc.first, rc.last, d).each do |nb|
      tmp1 += 1 if !r.include?(nb)
      sds << nb if !sds.include?(nb) && ( nb.first < 0 || nb.last < 0 || nb.first >= d.first.length || nb.last >= d.length || d[nb.last][nb.first] != d[rc.last][rc.first])
    end
  end

  n = []
  s = []
  e = []
  w = []
  sides = 0

  sds.sort_by{|s| s.first * 1000 + s.last}.each do |sd|
    x = sd.first
    y = sd.last
    sides += 1 if r.include?([x+1, y]) && !w.include?([x, y-1])  && !w.include?([x, y+1])
    sides += 1 if r.include?([x-1, y]) && !e.include?([x, y-1])  && !e.include?([x, y+1])
    sides += 1 if r.include?([x, y + 1]) && !n.include?([x- 1,y])  && !n.include?([x+ 1,y])
    sides += 1 if r.include?([x, y - 1]) && !s.include?([x- 1,y])  && !s.include?([x+ 1,y])
    w << sd if r.include?([x+1, y])
    e << sd if r.include?([x-1, y])
    n << sd if r.include?([x, y + 1])
    s << sd if r.include?([x, y - 1])
  end
  res += area * sides
  res1 += area * tmp1
end
p "Part1: #{res1}"
p "Part2: #{res}"
