require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

# d = lines(filename)
# d = lines_w_spaces(filename)
d = matrix(filename)
# d = matrix_i(filename)

s = nil
e = nil
d.each_with_index do |l, y|
  l.each_with_index do |c, x|
    s = [x, y] if c == 'S'
    e = [x, y] if c == 'E'
  end
end

d[s.last][s.first] = '.'
d[e.last][e.first] = '.'
q = [s]
v = {}
dir = 'E'
s << dir
v[s] = true
dis = {}
dis[s] = 0
par = {}
par[s] = nil

def nbs(f)
  x =f.first
  y = f[1]
  dir = f.last

  case dir
  when 'E'
    [
      [x + 1, y, 'E'],
      [x, y - 1, 'N'],
      [x, y + 1, 'S']
    ]
  when 'W'
    [
      [x - 1, y, 'W'],
      [x, y - 1, 'N'],
      [x, y + 1, 'S']
    ]
  when 'N'
    [
      [x - 1, y, 'W'],
      [x + 1, y, 'E'],
      [x, y - 1, 'N']
    ]
  when 'S'
    [
      [x - 1, y, 'W'],
      [x + 1, y, 'E'],
      [x, y + 1, 'S']
    ]
  end
end

re = []

h_re = {}

while q.any?
  f = q.shift
  if f[0..1] == e
    h_re[dis[f]] ||= 0
    h_re[dis[f]] += 1
    re << dis[f]
  end
  if nbs(f)
    nbs(f).select{|c| d[c[1]][c.first] == '.' }.each do |nb|
      next if v[nb] && dis[f] + (f.last == nb.last ? 1 : 1001) > dis[nb]

      v[nb] = true
      par[nb] = f
      q << nb
      dis[nb] = dis[f] + (f.last == nb.last ? 1 : 1001)
    end
  end
end

res = re.min

ccc = h_re[res]
p "Part1: #{res}"
paths = []
q = [s]
v = {}
v[s] = true
dis = {}
dis[s] = 0
par = {}
par[s] = nil

cc = 0

while q.any?
  f = q.shift
  if f[0..1] == e
    if dis[f] == res
      cc += 1
      if cc == ccc
        tmp = [f]
        done = []
        while tmp.any?
          ff = tmp.shift
          paths << ff[0..1] unless paths.include?(ff[0..1])
          if par[ff]
            par[ff].select{|y| y.last == par[ff].map(&:last).min }.each do |fff|
              next if done.include?([ff, fff.first])
              done << [ff, fff.first]
              tmp << fff.first unless tmp.include?(fff.first)
            end
          end
        end
      end
    end
  end

  if nbs(f)
    nbs(f).select{|c| d[c[1]][c.first] == '.' }.each do |nb|
      next if v[nb] && dis[f] + (f.last == nb.last ? 1 : 1001) > dis[nb]

      v[nb] = true
      par[nb] ||= []
      q << nb
      dis[nb] = dis[f] + (f.last == nb.last ? 1 : 1001)
      par[nb] << [f, dis[nb]]
    end
  end
end
p "yey"
p "Part2: #{paths.uniq.length}"

# Display map
# d.each_with_index do |l, y|
#   l.each_with_index do |c, x|
#     print(paths.include?([x,y]) ? 'O' : c)
#   end
#   print("\n")
# end
