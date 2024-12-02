require_relative 'lib'

day = 2
year = 2024
get_datas(day, year)

d = File.open("data_#{day}.txt").read.split("\n").map{|x| x.split(' ').map(&:to_i)}

res = 0

d.each do |l|
  n = l.length
  ok = false
  n.times do |i|
    break if ok
    ar = l.map{|x| x}
    ar.delete_at(i)
    cur = nil
    val = true
    asc = false
    desc = false
    ar.each do |x|
      if cur.nil?
        cur = x
      else
        val = false if (cur - x).abs > 3 || cur == x
        asc = true if x > cur
        desc = true if x < cur
        cur = x
      end
    end

    ok = true if val && ((asc && !desc) || (!asc && desc))
  end
  res += 1 if ok
end

p res
