require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

d = lines(filename)
# d = lines_w_spaces(filename)
# d = matrix(filename)
# d = matrix_i(filename)

def nbs_no_diag(x, y, d)
  [
    [x - 1, y],
    [x + 1, y],
    [x, y - 1],
    [x, y + 1]
  ].select{|c| c.first >= 0 && c.last >= 0 && c.first < d.first.length && c.last < d.length }
end

mat = []
71.times do
  tmp = []
  71.times do
    tmp << '.'
  end
  mat << tmp
end

s = [0, 0]


d[0..1023].each do |l|
  xi = l.split(',').first.to_i
  yi = l.split(',').last.to_i
  mat[yi][xi] = '#'
end

i = 1023
part1 = false

while true
  xi = d[i].split(',').first.to_i
  yi = d[i].split(',').last.to_i
  mat[yi][xi] = '#'

  q = [s]
  v = {}
  dis = {}
  v[s] = true
  dis[s] = 0
  val = false
  while q.any?
    f = q.shift
    if f == [70,70]
      p "Part1: #{dis[f]}" unless part1

      part1 = true
      val = true
    end
    x = f.first
    y = f.last
    nbs_no_diag(x, y, mat).select{|c| mat[c.last][c.first] == '.'}.each do |nb|
      next if v[nb]

      v[nb] = true
      q << nb
      dis[nb] = dis[f] + 1
    end
  end
  unless val
    p "YEY"
    p "Part2: #{d[i]}"
    return
  end
  i += 1
end
