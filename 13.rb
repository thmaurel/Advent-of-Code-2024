require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

d = lines(filename)
# d = lines_w_spaces(filename)
# d = matrix(filename)
# d = matrix_i(filename)

ms = []
m = []
d.each do |l|
  if l == ""
    ms << m
    m = []
  else
    m << l
  end
end
ms << m

res = 0
ms.map! do |m|
  a = m.first
  b = m[1]
  pri = m.last
  ax = a.split('+')[1].split(',').first.to_i
  ay = a.split('+').last.to_i

  bx = b.split('+')[1].split(',').first.to_i
  by = b.split('+').last.to_i

  prix = pri.split('=')[1].split(',').first.to_i
  priy = pri.split('=').last.to_i

  {a: [ax, ay], b: [bx, by], pri: [prix + 10000000000000, priy + 10000000000000]}
end

ms.each_with_index do |m, i|
  x = m[:pri].first
  y = m[:pri].last
  xa = m[:a].first
  ya = m[:a].last
  xb = m[:b].first
  yb = m[:b].last
  # Axa + Aya + Bxb + Byb = x y

  # A xa + B xb = x
  # A ya + B yb = y

  # A xa ya + B xb ya  = x ya
  # A xa ya + B xa yb = y xa

  # B xb ya - B xa yb = x ya - y xa
  # B = x ya - y xa / xb ya - xa yb

  # A = (x - B xb) / xa
  if xb / yb.to_f != xa / ya.to_f
  b = (x * ya - y  * xa ).to_f/ (xb * ya - xa * yb)
  a = (x - b * xb) / xa.to_f
  end

  if a.to_i == a && b.to_i == b
    res += 3 * a + b
  end
end

p res.to_i
