# Used this file to randomly try combinations hoping for a miracle

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

# d.each_with_index do |l, y|
#   l.each_with_index do |c, x|
#   end
# end

x = {}
y = {}

ins = []
ha = false
h = {}
d.each do |l|
  if ha
    ins << l
  else
    if l == ''
      ha = true
    elsif l.include?('x')
      h[l.split(':').first] = l.split(': ').last
    elsif l.include?('y')
      h[l.split(':').first] = l.split(': ').last
    else
      p "ERROR"
    end
  end
end

def xor(a, b)
  (a.to_i(2) ^b.to_i(2)).to_s(2)
end

def andd(a,b)
  res = a.to_i(2) & b.to_i(2)
  res.to_s(2)
end

def orr(a,b)
  res = a.to_i(2) | b.to_i(2)
  res.to_s(2)
end

q = ins.map{|x| x}

# start com
gts = ins.map{|l| l.split(' ').last}.uniq
# p gts.length
# return

# p gts
# return

# done = []
while true
# rd = gts.select{|x| x != 'kwb' && !x.match?(/z\d+/)}.sample(6)
gt1 = 'stj'
gt2 = 'wwd'
gt3 = 'z16'
gt4 = 'qkf'
gt5 = 'jqn'
gt6 = 'cph'
gt7 = 'z24'
gt8 = 'vhm'
# gt1 = rd[0]
ar = []
# done = []

# start

# probleme:
# x12 AND y12 -> z12

# exemple:
# 2 lignes pr x3, y3

# y03 XOR x03 -> tcb
# y03 AND x03 -> rfn

# les deux combi produites sont utilisés par:
# tcb XOR ptp -> z03
# tcb AND ptp -> fcs
# rfn OR fcs -> dbm

# celle qui fait z3 utilise aussi
# npq OR qvc -> ptp

# prf AND dvr -> npq semblable a z02
# x02 AND y02 -> qvc

# svv OR vpp -> prf
# x02 XOR y02 -> dvr

# gtb AND tdh -> svv
# x01 AND y01 -> vpp

# x00 AND y00 -> gtb
# y01 XOR x01 -> tdh

# ce qui faisait z2:
# prf XOR dvr -> z02
# ce qui fait z(i+1) est une combi semblable a celle faisant z(i)

# ma combinaison pr z12 doit donc être

# un truc qui prend x12 et y12
# x12 XOR y12 -> ggr
# x12 XOR y12 -> z12

# avec un truc prenant deux élements
# une combi semblable a z(i-1)
# bwt XOR gpc -> z11
# gpc AND bwt -> hcv <--- elle

# et une combi prenant juste x(i-1) y(i-1)
# y11 XOR x11 -> gpc
# x11 AND y11 -> hmn

# hmn OR hcv -> hnd <- c'est la combi prenant semblable z(i-1) et juste x(i-1) y(i-1)

# donc z12 doit être hnd et ggr
# ggr XOR hnd -> kwb

# il faut donc switch z12 et kwb

# ggr est = z12 a l'heure actuel



# uncomment from here
# gts.each do |gt1|
#   gts.each do |gt2|
#     next if gt2 == gt1 || done.include?([gt1, gt2].sort)
#     done << [gt1, gt2].sort
    # gts.each do |gt3|
    #   next if gt3 == gt1 || gt3 == gt2
    #   gts.each do |gt4|
    #     next if [gt1, gt2, gt3].include?(gt4)
    #     gts.each do |gt5|
    #       # p "tut"
    #       next if [gt1, gt2, gt3, gt4].include?(gt5)
    #       gts.each do |gt6|
    #         # p "tut"
    #         next if [gt1, gt2, gt3, gt4, gt5].include?(gt6)
            q = ins.map{|x| x}
            q.map! do |l|
            #   if l.split(' ').last == 'z12'
            #     l.gsub('z12', 'kwb')
            #   elsif l.split(' ').last == 'kwb'
            #     l.gsub('kwb', 'z12')
            #   else
            #     l
            #   end
            # end
              if l.split(' ').last == gt1
                l.gsub(gt1, gt2)
              elsif l.split(' ').last == gt2
                l.gsub(gt2, gt1)
              elsif l.split(' ').last == gt3
                l.gsub(gt3, gt4)
              elsif l.split(' ').last == gt4
                l.gsub(gt4, gt3)
              elsif l.split(' ').last == gt5
                l.gsub(gt5, gt6)
              elsif l.split(' ').last == gt6
                l.gsub(gt6, gt5)
              elsif l.split(' ').last == gt7
                l.gsub(gt7, gt8)
              elsif l.split(' ').last == gt8
                l.gsub(gt8, gt7)
              else
                l
              end
            end
            # c = 0
            pa = {}
            old_l = nil
            while q.any?
              # p "tit"
              break if old_l && q.length == old_l
              old_l = q.length
              to_rem = []
              q.each_with_index do |inst, i|
                a = h[inst.split(' ').first]
                b = h[inst.split(' ')[2]]
                if a && b
                  pa[inst.split(' ').last] = [inst.split(' ').first, inst.split(' ')[2]]
                  case inst.split(' ')[1]
                  when 'XOR'
                    h[inst.split(' ').last] = xor(a, b)
                  when 'OR'
                    h[inst.split(' ').last] = orr(a, b)
                  when 'AND'
                    h[inst.split(' ').last] = andd(a, b)
                  else
                    p "ERROR"
                  end
                  to_rem << i
                end
              end
              to_rem.reverse.each {|j| q.delete_at(j)}
            end

            x = h.keys.select{|c| c.match?(/x\d+/)}.sort_by{|c| c.gsub('x', '').to_i }.map{|y| h[y]}.reverse.join('').to_i(2)
            y = h.keys.select{|c| c.match?(/y\d+/)}.sort_by{|c| c.gsub('y', '').to_i }.map{|y| h[y]}.reverse.join('').to_i(2)
            z = h.keys.select{|c| c.match?(/z\d+/)}.sort_by{|c| c.gsub('z', '').to_i }.map{|y| h[y]}.reverse.join('').to_i(2)

            # p x.to_s(2)
            # p y.to_s(2)
            # p z.to_s(2)


            # p "Res:"
            # # p [gt1, gt2]
            # don = []
            # zs = gts.select{|x| x.match?(/z\d+/)}.sort
            # zs.each do |z|
            #   imp = pa[z]
            #   # don += pa[z]
            #   imp.each do |im|
            #     imp << pa[im].first << pa[im].last if pa[im]
            #     # don += pa[im] if pa[im]
            #   end
            #   p z
            #   n = z.gsub('z', '').to_i
            #   error = false
            #   (n + 1).times do |k|
            #     error = true unless imp.include?("x#{k < 10 ? "0#{k}" : k}")
            #     error = true unless imp.include?("y#{k < 10 ? "0#{k}" : k}")
            #   end
            #   p 'ERROR' if error
              # next if error && z != 'z12'
              # next if imp.sort.uniq.length == 2
              # p "STARTING #{gt1}" if error
              # p z if error
              # p imp.sort.uniq if error
            #   p imp.sort.uniq

            # end
            # probleme a z45
          # end
          # p gts - don - zs
            # p pa
            # p zs
            # p x + y
            # p z
            # z12
            # faut ggr -> kwb ou knh

            # x12 XOR y12 -> ggr
            # ggr XOR hnd -> kwb
            # ggr AND hnd -> knh

            # kwb OR knh -> vjq



            # tdh XOR gtb -> z01
            # y01 XOR x01 -> tdh
            # x00 AND y00 -> gtb
            # ["bnk", "pqw", "hnd", "ggr", "hmn", "hcv", "gtb", "z12"]

            # hsh OR vww -> z45
            # y44 AND x44 -> vww
            # wkb AND mhv -> hsh
            # vww
# return
            # ar << [x + y, z, gt1, gt2]
            p "Tried. Dif: #{x + y - z}. gts: #{[gt1, gt2, gt3, gt4, gt5, gt6, gt7, gt8].sort.join(',')}"
            # if (x + y - z).abs < 10000
            #   p "check"
            #   sleep 1
            # end
            if x + y == z
              p "OUAIS"
              p [gt1, gt2, gt3, gt4, gt5, gt6, gt7, gt8].sort.join(',')
              return
            end
    #       end
    #     end
    #   end
    # end
  # end
end
# p ar.sort_by{|x| (x.first - x[1]).abs}.map{|a| [(a.first - a[1]).abs] + a}

# p ar.map{|x| (x.first - x[1]).abs}.sort
# p ar.map{|x| (x.first - x[1]).abs}.length

# djq
# z24
# vhm
# z21
# phk
# dsh
# cdc
# wws

return
# end
# return
# p ar.sort_by{|x| x.first} #.first(4).map{|x| x[1..2]}.flatten.sort.join(',')
# return
# end com
# c = 0
while q.any?
  # p q.length
  # p h
  # p q
  # return if c == 1
  # c += 1
  to_rem = []
  q.each_with_index do |inst, i|
    a = h[inst.split(' ').first]
    b = h[inst.split(' ')[2]]
    if a && b
      case inst.split(' ')[1]
      when 'XOR'
        h[inst.split(' ').last] = xor(a, b)
      when 'OR'
        h[inst.split(' ').last] = orr(a, b)
      when 'AND'
        h[inst.split(' ').last] = andd(a, b)
      else
        p "ERROR"
      end
      to_rem << i
    end
  end
  to_rem.reverse.each {|j| q.delete_at(j)}
end

x = h.keys.select{|c| c.match?(/x\d+/)}.sort_by{|c| c.gsub('z', '').to_i }.map{|y| h[y]}.reverse.join('').to_i(2)
y = h.keys.select{|c| c.match?(/y\d+/)}.sort_by{|c| c.gsub('z', '').to_i }.map{|y| h[y]}.reverse.join('').to_i(2)
z = h.keys.select{|c| c.match?(/z\d+/)}.sort_by{|c| c.gsub('z', '').to_i }.map{|y| h[y]}.reverse.join('').to_i(2)

p x + y
p z


return
# Part 1
res = h.keys.select{|c| c.match?(/z\d+/)}.sort_by{|c| c.gsub('z', '').to_i }.map{|y| h[y]}.reverse.join('').to_i(2)


p res

return

submit(res.to_s, day, year)
