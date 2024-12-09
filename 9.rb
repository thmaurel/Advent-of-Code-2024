require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

d = lines(filename).first.split('').map(&:to_i)
# d = lines_w_spaces(filename)
# d = matrix(filename)
# d = matrix_i(filename)

res = 0
res1 = 0

id = 0
h = {}
fs = []

d.each_with_index do |c, i|
  if i.even?
    h[id] = {size: c, pos: i}
    id += 1
  else
    fs << {size: c, pos: i}
  end
end

mid = h.keys.max

(1..mid).to_a.reverse.each do |x|
  s = h[x][:size]
  pos = h[x][:pos]
  move = true
  fs.each_with_index do |fsp, j|
    break unless move
    break if fsp[:pos] > pos
    if fsp[:size] == s
      move = false
      fs << {size: s, pos: pos}
      fs.sort_by!{|x| x[:pos]}
      h[x][:pos] = fsp[:pos]
      fs.delete_at(j)
      break
    elsif fsp[:size] > s
      move = false
      fs << {size: s, pos: pos}
      fs.sort_by!{|x| x[:pos]}
      h[x][:pos] = fsp[:pos]
      h.each do |k, v|
        next unless v[:pos] > fsp[:pos]
        h[k][:pos] += 1
      end
      fs.each_with_index do |fspa, k|
        next unless fspa[:pos] > fsp[:pos]
        fs[k][:pos] += 1
      end
      fs[j][:size] -= s

      fs[j][:pos] += 1
    end
  end
end


mp = h.values.map{|x| x[:pos]}.max

i = 0
str = ''
(0..mp).to_a.each do |pos|
  cur = h.find{|k, v| v[:pos] == pos}
  if cur
    id = cur.first
    sz = cur.last[:size]
    sz.times do |j|
      res += i * id
      str += id.to_s
      i += 1
    end
  end
  cur = fs.find{|fsp| fsp[:pos] == pos}
  if cur
    sz = cur[:size]
    sz.times do |j|
      str+= '.'
      i += 1
    end
  end
end

# part 1

tmp = []
id = 0

d.each_with_index do |c, i|
  if i.even?
    c.times do |j|
      tmp << id
    end
    id += 1
  else
    c.times do |j|
      tmp << '.'
    end
  end
end

tt = []
stop = false
tmp.each_with_index do |c, j|
  next if tmp[j..-1].uniq == ['.']
  if c == '.'
    v = nil
    ind = nil
    tmp.reverse.each_with_index do |x, i|
      next if x == '.'
      break if v

      v = x
      ind = tmp.length - 1 - i
    end
    stop = true unless ind
    tt << v
    tmp[ind] = '.'
  else
    tt << c
  end
end

tt.each_with_index do |x, i|
  res1 += x * i
end

p "Part1: #{res1}"
p "Part2: #{res}"
