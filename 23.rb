# I guess I've been lucky on part2 that input lets it work x)

require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

d = lines(filename)
# d = lines_w_spaces(filename)
# d = matrix(filename)
# d = matrix_i(filename)

nbs = {}
cps = []

d.each do |l|
  a = l.split('-').first
  b = l.split('-').last
  cps << a unless cps.include?(a)
  cps << b unless cps.include?(b)
  nbs[a] ||= []
  nbs[a] << b
  nbs[b] ||= []
  nbs[b] << a
end

gs = []
gs1 = []

cps.each do |cp|
  # part 2
  ar = nbs[cp] + [cp]
  nbs[cp].each do |nb|
    next if (ar & nbs[nb]).length == 1

    ar &= nbs[nb] + [nb]
  end
  gs << ar.sort unless gs.include?(ar.sort)

  # part 1
  nbs[cp].each do |nb|
    nbs[cp].each do |nbb|
      next if nb == nbb

      gs1 << [cp, nb, nbb].sort if nbs[nb].include?(nbb) && !gs1.include?([cp, nb, nbb].sort)
    end
  end
end

res1 = gs1.select{|g| g.map{|y| y[0]}.include?('t')}.count
res =  gs.select{|x| x.length == gs.map{|y| y.length}.max}.flatten.join(',')

p "Part1: #{res1}"
p "Part2: #{res}"
