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

s = nil
e = nil

d.each_with_index do |l, y|
  l.each_with_index do |c, x|
    s = [x, y] if c == "S"
    e = [x, y] if c == 'E'
  end
end

d[s.last][s.first] = '.'
d[e.last][e.first] = '.'

q = [s]
v= {}
v[s] = true
dis = {}
dis[s] = 0
tot = 0
ord = [s]

while q.any?
  f = q.shift
  x = f.first
  y = f.last
  if f == e
    tot = dis[f]
    break
  end
  nbs_no_diag(x, y, d).each do |nb|
    next if d[nb.last][nb.first] == '#' || v[nb]

    dis[nb] = dis[f] + 1
    q << nb
    ord << nb
    v[nb] = true
  end
end

# this is the way I did Part1, but not recommended: was super long
# res = []
#   d.length.times do |j|
#     d.first.length.times do |i|
#       next if d[j][i] != '#' || nbs_no_diag(i, j, d).map{|nb| d[nb.last][nb.first]}.count('.') < 2
#       # p "#{i} / #{d.first.length} && #{j} / #{d.length}"
#       mat = d.map{|x| x.map{|y| y}}
#       mat[j][i] = '.'
#       q = [s]
#       v= {}
#       v[s] = true
#       dista = {}
#       dista[s] = 0

#       while q.any?
#         f = q.shift
#         x = f.first
#         y = f.last
#         if f == e
#           res << dista[f]
#           break
#         end
#         nbs_no_diag(x, y, mat).each do |nb|
#           next if mat[nb.last][nb.first] == '#' || v[nb]

#           dista[nb] = dista[f] + 1
#           q << nb
#           v[nb] = true
#         end
#       end
#     end
#   end

# p "Part1 : #{res.map{|x| tot - x}.select{|y| y >= 100}.length}"


q = [s]
v= {}
v[s] = true
dist = {}
dist[s] = 0
tot = 0
res = 0
res1 = 0
while q.any?
  f = q.shift
  x = f.first
  y = f.last
  ord.select{|ordo| (ordo.last - y).abs + (ordo.first - x).abs <= 20}.each do |ordo|
    res += 1 if dist[f] + (ordo.last - y).abs + (ordo.first - x).abs <= dis[ordo] - 100
  end
  ord.select{|ordo| (ordo.last - y).abs + (ordo.first - x).abs <= 2}.each do |ordo|
    res1 += 1 if dist[f] + (ordo.last - y).abs + (ordo.first - x).abs <= dis[ordo] - 100
  end
  if f == e
    tot = dist[f]
    break
  end
  nbs_no_diag(x, y, d).each do |nb|
    next if d[nb.last][nb.first] == '#' || v[nb]
    dist[nb] = dist[f] + 1
    q << nb
    ord << nb
    v[nb] = true
  end
end

p "Part1: #{res1}"
p "Part2: #{res}"
