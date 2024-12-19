require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

d = lines(filename)

aves = d.first
d = d[2..-1]

avs = aves.split(', ')

res = 0

d.each_with_index do |l, i|
  todo = [l]
  while todo.any?
    todo.sort_by!{|x| x.length}
    f = todo.shift
    if f == ''
      res += 1
      break
    end
    avs.each do |av|
      if f[0..av.length-1] == av
        todo << f[av.length..-1]
      end
    end
  end
end

p "Part1: #{res}"
res = 0

d.each_with_index do |l, i|
  h = {}
  todo = [l]
  while todo.any?
    todo.sort_by!{|x| -x.length}
    f = todo.shift
    if f == ''
      res += h[f]
    end
    avs.each do |av|
      if f[0..av.length-1] == av
        h[f[av.length..-1]] ||= 0
        h[f[av.length..-1]] += (h[f] || 1)
        todo << f[av.length..-1] unless todo.include?(f[av.length..-1])
      end
    end
  end
end

p "Part2: #{res}"
