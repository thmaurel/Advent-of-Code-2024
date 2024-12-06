# /!\ Part 2 takes a longggggg time

require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

# d = lines(filename)
# d = lines_w_spaces(filename)
d = matrix(filename)
# d = matrix_i(filename)

res = 0
dir = 'N'

s = nil

d.each_with_index do |l, y|
  l.each_with_index do |c, x|
    s = [x, y] if c == '^'
  end
end

d[s.last][s.first] = '.'

real_s = s.map{|x| x}

vs = []
run = true

res = 0

def move(dir, x, y, run, d)
  s = [x, y]
  case dir
  when 'N'
    if y == 0
      run = false
    elsif d[y -1][x] == '.'
      s = [x, y-1]
    else
      dir = 'E'
    end
  when 'E'
    if x == d.first.length - 1
      run = false
    elsif d[y][x + 1] == '.'
      s = [x +1, y]
    else
      dir = 'S'
    end
  when 'S'
    if y == d.length - 1
      run = false
    elsif d[y +1][x] == '.'
      s = [x, y+1]
    else
      dir = 'W'
    end
  when 'W'
    if x == 0
      run = false
    elsif d[y][x - 1] == '.'
      s = [x - 1, y]
    else
      dir = 'N'
    end
  end
  return {dir: dir, s: s, run: run}
end

while run
  vs << s unless vs.include?(s)
  x = s.first
  y = s.last

  mov = move(dir, x, y, run, d)
  s = mov[:s]
  dir = mov[:dir]
  run = mov[:run]
end

vvs = vs.map{|x| x}
p "Part1: #{vvs.length}"

prev = nil
ccc = 0
d.each_with_index do |l, j|
  l.each_with_index do |c, i|
    next if !vvs.include?([i, j]) || real_s == [i, j]

    ccc += 1
    # p "Done: #{ccc}/5067"
    d[prev.last][prev.first] = '.' if prev
    prev = [i, j]
    s = real_s
    d[j][i] = '#'

    vs = []
    run = true
    dir = 'N'
    while run
      x = s.first
      y = s.last
      if vs.include?([x, y, dir])
        res += 1
        break
      end
      vs << [x, y, dir] unless vs.include?([x, y, dir])

      case dir
      when 'N'
        if y == 0
          run = false
        elsif d[y -1][x] == '.'
          s = [x, y-1]
        else
          dir = 'E'
        end
      when 'E'
        if x == d.first.length - 1
          run = false
        elsif d[y][x + 1] == '.'
          s = [x +1, y]
        else
          dir = 'S'
        end
      when 'S'
        if y == d.length - 1
          run = false
        elsif d[y +1][x] == '.'
          s = [x, y+1]
        else
          dir = 'W'
        end
      when 'W'
        if x == 0
          run = false
        elsif d[y][x - 1] == '.'
          s = [x - 1, y]
        else
          dir = 'N'
        end
      end
    end
  end
end

p "Part2: #{res}"
