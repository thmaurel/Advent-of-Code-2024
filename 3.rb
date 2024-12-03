require_relative 'lib'

day = 3
year = 2024
get_datas(day, year)

d = File.open("data_#{day}.txt").read.split("\n") #.map{|x| x.split(' ').map(&:to_i)}

res = 0

[d.reduce(&:+)].each do |l|
  val = true
  l.scan(/(mul\(\d+,\d+\))|(do\(\))|(don't\(\))/).each do |c|
    if c[1]
      val = true
    elsif c.last
      val = false
    else
      num = c.first.split('(').last.split(')').first.split(',')

      res += num.first.to_i * num.last.to_i if val
    end
  end
end

p res
