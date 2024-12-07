require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

d = lines_w_spaces(filename).map{|x| x.map{|y| y.gsub(':', '').to_i}}

res1 = 0
res2 = 0

d.each do |l|
  r = l.first
  ad = l[1..-1]
  pos1 = [ad.first]
  pos2 = [ad.first]
  ad[1..-1].each do |x|
    tmp1 = []
    tmp2 = []
    pos1.each do |po|
      tmp1 << po * x
      tmp1 << po + x
    end
    pos2.each do |po|
      tmp2 << po * x
      tmp2 << po + x
      tmp2 << (po.to_s + x.to_s).to_i
    end
    pos1 = tmp1
    pos2 = tmp2
  end
  res1 += r if pos1.include?(r)
  res2 += r if pos2.include?(r)
end

p "Part1: #{res1}"
p "Part2: #{res2}"
