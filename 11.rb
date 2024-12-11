require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

# d = lines(filename)
d = lines_w_spaces(filename).first.map(&:to_i)
# d = matrix(filename)
# d = matrix_i(filename)

res = 0

def next_a(c)
  if c == 0
    [1]
  elsif c.to_s.split('').length.even?
    [c.to_s.split('')[0..c.to_s.split('').length / 2 - 1].join('').to_i, c.to_s.split('')[c.to_s.split('').length / 2..-1].join('').to_i]
  else
    [c * 2024]
  end
end

[25, 75].each_with_index do |n, i|
  h = {}

  d.each do |x|
    h[x] ||= 0
    h[x] += 1
  end


  n.times do |i|
    f = {}
    h.keys.select{ |x| h[x] > 0 }.each do |k|
      nks = next_a(k)
      nks.each do |nk|
        f[nk] ||= 0
        f[nk] += h[k]
      end
    end
    h = f
  end

  res = h.values.sum
  p "Part#{i + 1}: #{res}"
end
