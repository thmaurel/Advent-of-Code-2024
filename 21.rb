cds = open('data_21.txt').read.split("\n")
# cds = ['029A']

def nbs_d(str)
  case str
  when 'A'
    [['0', '<'], ['3', '^']]
  when '0'
    [['A', '>'], ['2', '^']]
  when '1'
    [['2', '>'], ['4', '^']]
  when '2'
    [['1', '<'], ['3', '>'], ['5', '^'], ['0', 'v']]
  when '3'
    [['2', '<'], ['6', '^'], ['A', 'v']]
  when '4'
    [['5', '>'], ['7', '^'], ['1', 'v']]
  when '5'
    [['4', '<'], ['6', '>'], ['8', '^'], ['2', 'v']]
  when '6'
    [['5', '<'], ['9', '^'], ['3', 'v']]
  when '7'
    [['8', '>'], ['4', 'v']]
  when '8'
    [['7', '<'], ['9', '>'], ['5', 'v']]
  when '9'
    [['8', '<'], ['6', 'v']]
  end
end

def nbs_r(str)
  case str
  when '<'
    [['v', '>']]
  when 'v'
    [['<', '<'], ['>', '>'], ['^', '^']]
  when '>'
    [['v', '<'], ['A', '^']]
  when '^'
    [['v', 'v'], ['A', '>']]
  when 'A'
    [['^', '<'], ['>', 'v']]
  end
end


def get_robot_press(str)
  s = 'A'
  e = str[0]
  res = {}
  str.length.times do |i|
    qs = ['', s]
    q = [qs]
    dis = nil
    tmpp = []
    while q.any?
      f = q.shift
      if f.last == e
        dis = f.first.length
        tmpp << f.first + 'A' if tmpp.empty? || tmpp.first.length - 1 == f.first.length
      end
      nbs_r(f.last).each do |nb|
        st = f.first + nb.last
        q << [st, nb.first] if dis.nil? || st.length <= dis
      end
    end
    res[i] = tmpp
    s = e
    e = str[i + 1]
  end
  return res
end

CACHE = {}

def robots(str, n, max)
  return CACHE[[str, n, max]] if CACHE[[str, n, max]]

  sum = get_robot_press(str).map do |k,v|
    res = []
    v.each do |val|
      if n < max
        res << robots(val, n + 1, max)
      else
        res << val.length
      end
    end
    min = res.min
  end.sum
  CACHE[[str, n, max]] = sum
end

sol = 0
sol1= 0

cds.each do |cd|
  s = 'A'
  e = cd[0]
  res = {}
  4.times do |i|
    qs = ['', s]
    q = [qs]
    dis = nil
    tmpp = []
    while q.any?
      f = q.shift
      if f.last == e
        dis = f.first.length
        tmpp << f.first + 'A' if tmpp.empty? || tmpp.first.length - 1 == f.first.length
      end
      nbs_d(f.last).each do |nb|
        st = f.first + nb.last
        q << [st, nb.first] if dis.nil? || st.length <= dis
      end
    end
    res[i] = tmpp
    s = e
    e = cd[i + 1]
  end
  # res_4 = {}
  tmpp = 0
  res.each do |k, v|
    tmp = []
    v.each do |ps_press|
      # ce que doit presser le premier robot télécommande
      # summm = 0
      # get_robot_press(ps_press).each do |kk, vv|
      #   vv.each do |pp_p|
      #     # ce que doit presser le second robot télécommande
      #     summ = 0
      #     get_robot_press(pp_p).each do |kkk, vvv|
      #       vvv.each do |ppp_p|
      #         # ce que je dois presser
      #         res_4[k] ||= {}
      #         res_4[k][ps_press] ||= {}
      #         res_4[k][ps_press][kk] ||= {}
      #         res_4[k][ps_press][kk][pp_p] ||= {}
      #         res_4[k][ps_press][kk][pp_p][kkk] ||= {}
      #         res_4[k][ps_press][kk][pp_p][kkk][ppp_p] = ppp_p.length
      #       end
      #       res_4[k][ps_press][kk][pp_p][kkk] = res_4[k][ps_press][kk][pp_p][kkk].values.min
      #       summ += res_4[k][ps_press][kk][pp_p][kkk]
      #     end
      #     res_4[k][ps_press][kk][pp_p] = summ
      #   end
      #   res_4[k][ps_press][kk] = res_4[k][ps_press][kk].values.min
      #   summm += res_4[k][ps_press][kk]
      # end
      # res_4[k][ps_press] = summm
      tmp << robots(ps_press, 1, 25)
    end
    tmpp += tmp.min
  end
  sol += tmpp * cd.gsub('A', '').to_i

  # this is doing part1 the same way I did part2, the actual way I did it was thro the commented code on top, painful
  tmpp1 = 0

  res.each do |k, v|
    tmp1 = []
    v.each do |p1|
      tmp1 << robots(p1, 1, 2)
    end
    tmpp1 += tmp1.min
  end
  sol1 += tmpp1 * cd.gsub('A', '').to_i
end

p "Part1: #{sol1}"
p "Part: #{sol}"
