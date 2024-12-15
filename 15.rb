# I"m not going to clean this code
# nonono
# all the comments gonna remain
# part2 first, part1 after

require_relative 'lib'
require 'pry-byebug'
day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

# d = lines(filename)
# d = lines_w_spaces(filename)
d = matrix(filename)
# d = matrix('ma.txt')
# d = matrix_i(filename)

ins = open('data_15_2.txt').read.split("\n").join('').split('')
# ins = open('ins.txt').read.split("\n").join('').split('')

res = 0
s = nil

nd = []
d.each_with_index do |l, y|
  nl = []
  l.each_with_index do |c, x|
    if c == '#'
      nl << '#' << '#'
    elsif c == 'O'
      nl << '[' << ']'
    elsif c == '.'
      nl << '.' << '.'
    elsif c == '@'
      nl << '@' << '.'
    else
      p "NOOOOO"
    end
  end
  nd << nl
end
d = nd

# d = "##############
# ##..........##
# ##.....[]...##
# ##........[]##
# ##....[]....##
# ##..[][]....##
# ##....@[]...##
# ##..##......##
# ##############".split("\n").map{|x| x.split('')}

# ins = '^^^^^>><<<vv>v<<<<<'.split('')

# p ins
# p "test"
# p d.flatten.count('[')

def print_d(d, tmp = nil)
  d.each_with_index do |l, y|
    l.each_with_index do |c, x|
      if tmp == [x, y]
        print '@'
      else
        print c
      end
    end
    p "\n"
  end
end


d.each_with_index do |l, y|
  l.each_with_index do |c, x|
    s = [x,y] if c == '@'
  end
end

d[s.last][s.first] = '.'


def move(x, y, inst, d)
  case inst
  when '<'
    if d[y][x-1] == '.'
      return [x-1, y]
    elsif d[y][x-1] == '#'
      return [x, y]
    end
  when '>'
    if d[y][x+1] == '.'
      return [x+1, y]
    elsif d[y][x+1] == '#'
      return [x, y]
    end
  when 'v'
    if d[y+1][x] == '.'
      return [x, y+1]
    elsif d[y+1][x] == '#'
      return [x, y]
    end
  when '^'
    if d[y-1][x] == '.'
      return [x, y-1]
    elsif d[y-1][x] == '#'
      return [x, y]
    end
  end
  # hard moves
  case inst
  when '<'
    if d[y][x-1] == ']'
      push = true
      i = 1
      while push
        if d[y][x - 1 - 2*i] == '.'
          i.times do |k|
            d[y][x - 1 - 2*i + 2*k] = '['
            d[y][x - 1 - 2*i + 2*k + 1] = ']'
          end
          d[y][x - 1] = '.'
          return [x-1, y]
        elsif d[y][x - 1 - 2*i] == '#'
          return [x, y]
        elsif d[y][x - 1 - 2*i] == ']'
          i += 1
        end
      end
    else
      p "ERROR"
    end
  when '>'
    if d[y][x+1] == '['
      push = true
      i = 1
      while push
        if d[y][x + 1 + 2*i] == '.'
          i.times do |k|
            d[y][x + 1 + 2*i - 2*k] = ']'
            d[y][x + 1 + 2*i - 2*k - 1] = '['
          end
          d[y][x + 1] = '.'
          return [x+1, y]
        elsif d[y][x + 1 + 2*i] == '#'
          return [x, y]
        elsif d[y][x + 1 + 2*i] == '['
          i += 1
        end
      end
    else
      p "ERROR"
    end
  when '^'
    to_moves = []
    if d[y-1][x] == '['
      if can_move_top(x,y-1,d, to_moves)
        to_moves.uniq.sort_by{|tm| tm.last * 1000 + tm.first}.each do |tm|
          move_top(tm.first, tm.last, d)
        end
        move_top(x, y-1, d)
        return [x, y-1]
      else
        return [x, y]
      end
    elsif d[y-1][x] == ']'
      if can_move_top(x - 1,y-1,d, to_moves)
        to_moves.uniq.sort_by{|tm| tm.last * 1000 + tm.first}.each do |tm|
          move_top(tm.first, tm.last, d)
        end
        move_top(x-1, y-1, d)
        return [x, y-1]
      else
        return [x, y]
      end
    else
      p "ERROR"
    end
  when 'v'
    to_moves = []
    if d[y+1][x] == '['
      if can_move_bot(x,y+1,d,to_moves)
        to_moves.uniq.sort_by{|tm| tm.last * -1000 - tm.first}.each do |tm|
          move_bot(tm.first, tm.last, d)
        end
        move_bot(x,y+1,d)
        return [x, y+1]
      else
        return [x, y]
      end
    elsif d[y+1][x] == ']'
      if can_move_bot(x - 1,y+1,d, to_moves)
        to_moves.uniq.sort_by{|tm| tm.last * -1000 - tm.first}.each do |tm|
          move_bot(tm.first, tm.last, d)
        end
        move_bot(x - 1,y+1,d)
        return [x, y+1]
      else
        return [x, y]
      end
    else
      p "ERROR"
    end
  else
    p "RATE"
  end
  p "GROSSE ERREUR"
end

def move_top(x, y, d)
  d[y-1][x] = '['
  d[y-1][x+1] = ']'
  d[y][x] = '.'
  d[y][x+1] = '.'
  return true
end
# verif que move_top écrase pas un caillou avec les .

def can_move_top(x,y,d, to_moves)
  # une pierre en x, x+1
  if d[y-1][x] == '.' && d[y-1][x+1] == '.'
    # move_top(x, y, d)
    return true
  elsif d[y-1][x] == '#' || d[y-1][x+1] == '#'
    return false
  elsif d[y-1][x] == '['
    # return move_top(x, y-1, d) if can_move_top(x, y-1,d)
    if can_move_top(x, y-1,d, to_moves)
      to_moves << [x, y-1]
      return true
    end
    return false
  elsif d[y-1][x] == ']' && d[y-1][x+1] == '['
    # return (move_top(x-1, y-1, d) && move_top(x+1, y-1, d)) if (can_move_top(x-1, y-1,d) && can_move_top(x+1, y-1,d))
    if (can_move_top(x-1, y-1,d, to_moves) && can_move_top(x+1, y-1,d, to_moves))
      to_moves << [x-1, y-1] << [x+1, y-1]
      return true
    end
    return false
  elsif d[y-1][x] == ']'
    # return move_top(x-1, y-1, d) if can_move_top(x-1, y-1,d)
    if can_move_top(x-1, y-1,d, to_moves)
      to_moves << [x-1, y-1]
      return true
    end
    return false
  elsif d[y-1][x+1] == '['
    # return move_top(x+1, y-1, d) if can_move_top(x+1, y-1,d)
    if can_move_top(x+1, y-1,d, to_moves)
      to_moves << [x+1, y-1]
      return true
    end
    return false
  else
    p "ERROR_can_move_top"
  end
end

def move_bot(x, y, d)
  d[y+1][x] = '['
  d[y+1][x+1] = ']'
  d[y][x] = '.'
  d[y][x+1] = '.'
  true
end

def can_move_bot(x,y,d, to_moves)
  # une pierre en x, x+1
  # p x
  # p y
  # # d[y-5..y+5].each do |l|
  # #   p l[x-5..x+5].join('')
  # # end
  # p "yo"
  # p d[y+1][x] == '.'
  # p d[y+1][x+1] == '.'
  if d[y+1][x] == '.' && d[y+1][x+1] == '.'
    # move_bot(x, y, d)
    return true
  elsif d[y+1][x] == '#' || d[y+1][x+1] == '#'
    return false
  elsif d[y+1][x] == '['
    # return move_bot(x, y + 1, d) if can_move_bot(x, y+1,d)
    if can_move_bot(x, y+1,d, to_moves)
      to_moves << [x, y+1]
      return true
    end
    return false
  elsif d[y+1][x] == ']' && d[y+1][x+1] == '['
    # return (move_bot(x-1, y+1, d) && move_bot(x+1, y+1, d)) if (can_move_bot(x-1, y+1,d) && can_move_bot(x+1, y+1,d))
    if (can_move_bot(x-1, y+1,d,to_moves) && can_move_bot(x+1, y+1,d,to_moves))
      to_moves << [x-1, y+1] << [x+1, y+1]
      return true
    end
    return false
  elsif d[y+1][x] == ']'
    # return move_bot(x-1, y+1, d) if can_move_bot(x-1, y+1,d)
    if can_move_bot(x-1, y+1,d,to_moves)
      to_moves << [x-1, y+1]
      return true
    end
    return false
  elsif d[y+1][x+1] == '['
    # return move_bot(x+1, y+1, d) if can_move_bot(x+1, y+1,d)
    if can_move_bot(x+1, y+1,d,to_moves)
      to_moves << [x+1, y+1]
      return true
    end
    return false
  else
    p "ERROR_can_move_bot"
  end
end


tmp = s
tmp2 =nil

# p ins.count
ins.each_with_index do |inst, j|
  # p j + 1
  # p "Ins is #{inst}"
  x = tmp.first
  y = tmp.last
  # d[y-5..y+5].each do |l|
  #   p l[x-5..x+5].join('')
  # end
  tmp2 = tmp
  # p "cur @: x:#{x}, y:#{y}"
  tmp = move(x, y, inst, d)
  p "NOOOO"if (tmp2.first - tmp.first).abs + (tmp2.last - tmp2.last).abs > 1
  # p "move"if (tmp2.first - tmp.first).abs + (tmp2.last - tmp2.last).abs == 1
  # p "doesnt"if (tmp2.first - tmp.first).abs + (tmp2.last - tmp2.last).abs < 1
  # print_d(d, tmp)
end
# print_d(d, tmp)

d.each_with_index do |l, y|
  l.each_with_index do |c, x|
    res += y * 100 + x if c == '['
  end
end

# p "test2"
# p d.flatten.count('[')
# p res
# submit(res.to_s, day, year)
# 1487652 too high
# p "done"



# =================================================
# =================================================
# Part1 below
# =================================================
# =================================================

d = matrix(filename)
# d = matrix('ma.txt')
# d = matrix_i(filename)

ins = open('data_15_2.txt').read.split("\n").join('').split('')

s = nil
d.each_with_index do |l, y|
  l.each_with_index do |c, x|
    s = [x,y] if c == '@'
  end
end

d[s.last][s.first] = '.'

def move_1(x, y, inst, d)
  case inst
  when '<'
    if d[y][x-1] == '.'
      return [x-1, y]
    elsif d[y][x-1] == '#'
      return [x, y]
    elsif d[y][x-1] == 'O'
      push = true
      i = 1
      while push
        if d[y][x - 1 - i] == '.'
          d[y][x - 1 - i] = 'O'
          d[y][x - 1] = '.'
          return [x-1, y]
        elsif d[y][x - 1 - i] == '#'
          return [x, y]
        elsif d[y][x - 1 - i] == 'O'
          i += 1
        end
      end
    else
      p "ERROR"
    end
  when '>'
    if d[y][x+1] == '.'
      return [x+1, y]
    elsif d[y][x+1] == '#'
      return [x, y]
    elsif d[y][x+1] == 'O'
      push = true
      i = 1
      while push
        if d[y][x + 1 + i] == '.'
          d[y][x + 1 + i] = 'O'
          d[y][x + 1] = '.'
          return [x+1, y]
        elsif d[y][x + 1 + i] == '#'
          return [x, y]
        elsif d[y][x + 1 + i] == 'O'
          i += 1
        end
      end
    else
      p "ERROR"
    end
  when 'v'
    if d[y+1][x] == '.'
      return [x, y+1]
    elsif d[y+1][x] == '#'
      return [x, y]
    elsif d[y+1][x] == 'O'
      push = true
      i = 1
      while push
        if d[y + 1 + i][x] == '.'
          d[y + 1 + i][x] = 'O'
          d[y + 1][x] = '.'
          return [x, y+1]
        elsif d[y+1 + i][x] == '#'
          return [x, y]
        elsif d[y+1][x] == 'O'
          i += 1
        end
      end
    else
      p "ERROR"
    end
  when '^'
    if d[y-1][x] == '.'
      return [x, y-1]
    elsif d[y-1][x] == '#'
      return [x, y]
    elsif d[y-1][x] == 'O'
      push = true
      i = 1
      while push
        if d[y - 1 - i][x] == '.'
          d[y - 1 - i][x] = 'O'
          d[y - 1][x] = '.'
          return [x, y-1]
        elsif d[y-1 - i][x] == '#'
          return [x, y]
        elsif d[y-1][x] == 'O'
          i += 1
        end
      end
    else
      p "ERROR"
    end
  end
end

tmp = s
ins.each do |inst|
  # p "Ins is #{inst}"
  x = tmp.first
  y = tmp.last
  tmp = move_1(x, y, inst, d)

end
res1 = 0
d.each_with_index do |l, y|
  l.each_with_index do |c, x|
    res1 += y * 100 + x if c == 'O'
  end
end

p "Part1: #{res1}"
p "Part2: #{res}"
