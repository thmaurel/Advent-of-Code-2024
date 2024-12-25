require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

d = lines(filename)
# d = lines_w_spaces(filename)
# d = matrix(filename)
# d = matrix_i(filename)
res = 0

ls = []
ks = []

ne = true
ty = false
tmp = nil
d.each do |l|
  if ne
    tmp = []
    tmp << l.split('')
    ty = l.include?('.') ? 'lock' : 'key'
    ne = false
  elsif l == ''
    ne = true
    ty == 'lock' ? ls << tmp : ks << tmp
  else
    tmp << l.split('')
  end
end

ty == 'lock' ? ls << tmp : ks << tmp

ks.each do |k|
  ls.each do |l|
    lc = l.transpose.map{|li| li.count('#')}
    kc = k.transpose.map{|li| li.count('#')}
    val = true
    lc.each_with_index do |lci, i|
      val = false if lci + kc[i] > 7
    end
    res += 1 if val
  end
end

p res
