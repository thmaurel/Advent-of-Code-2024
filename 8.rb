require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

# d = lines(filename)
# d = lines_w_spaces(filename)
d = matrix(filename)
# d = matrix_i(filename)

h = {}
hr1 = []
hr = []

d.each_with_index do |l, y|
  l.each_with_index do |c, x|
    next if c == '.'

    h[c] ||= []
    h[c] << [x, y]
  end
end

h.each do |k, v|
  v.each do |c|
    v.each do |cc|
      next if c == cc

      hr << [c.first, c.last] if !hr.include?([c.first, c.last])
      hr << [cc.first, cc.last] if !hr.include?([cc.first, cc.last])

      xd = (cc.first - c.first)
      yd = (cc.last - c.last)


      t = true
      i = 1
      while t
        nx = c.first - i * xd
        ny = c.last - i * yd

        hr << [nx, ny] if !hr.include?([nx, ny]) && nx >= 0 && ny >= 0 && nx < d.first.length && ny < d.length
        hr1 << [nx, ny] if !hr1.include?([nx, ny]) && nx >= 0 && ny >= 0 && nx < d.first.length && ny < d.length && i == 1
        i += 1
        t = false unless nx >= 0 && ny >= 0 && nx < d.first.length && ny < d.length
      end
      t = true
      i = 1
      while t
        nnx = cc.first + i * xd
        nny = cc.last + i * yd
        hr << [nnx, nny] if !hr.include?([nnx, nny]) && nnx >= 0 && nny >= 0 && nnx < d.first.length && nny < d.length
        hr1 << [nnx, nny] if !hr1.include?([nnx, nny]) && nnx >= 0 && nny >= 0 && nnx < d.first.length && nny < d.length && i == 1
        i += 1
        t = false unless nnx >= 0 && nny >= 0 && nnx < d.first.length && nny < d.length
      end
    end
  end
end

res = hr.length
res1 = hr1.length

p res1
p res
