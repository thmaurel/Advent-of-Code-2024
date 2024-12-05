require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

d = lines(filename)

spl = d.index('')

ru = d[0..spl - 1].map{|x| x.split('|')}
pr = d[spl + 1..-1]

res = 0

h = {}
ru.each do |x|
  h[x.first] ||= []
  h[x.first] << x.last
end

uno = []

pr.each_with_index do |l|
  x = l.split(',')
  val = true
  x.each_with_index do |c, i|
    x.each_with_index do |e, j|
      next if i == j || h[x[j]].nil?
      # p h[x[j]]
      if i < j && h[x[j]].include?(x[i])
        val = false
      end
    end
  end
  uno << l unless val
  res += x[x.length / 2].to_i if val
end

p "Part1: #{res}"

res = 0

uno.each do |l|
  x = l.split(',')
  co = []

  x.each_with_index do |c, i|
    val = true
    x.each_with_index do |e, j|
      next if i == j || h[x[j]].nil?

      if h[x[j]].include?(x[i])
        val = false
      end
    end
    co << c if val
  end

  while co.length != x.length
    tmp = nil
    (x - co).each_with_index do |c, i|
      val = true
      (x - co).each_with_index do |e, j|
        next if i == j || h[(x - co)[j]].nil?

        if h[(x - co)[j]].include?((x - co)[i])
          val = false
        end
      end
      tmp = c if val
    end
    co << tmp
  end
  res += co[co.length/2].to_i
end

p "Part2: #{res}"
