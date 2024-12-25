# Used this file at some point to clean a little bit 24.rb without losing it
# basically the same thing with useless code/comments removed x)

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
  (a.to_i(2) ^ b.to_i(2)).to_s(2)
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
# gts = ins.map{|l| l.split(' ').last}.uniq
# p gts.length
# return

# p gts
# return

# done = []
# while true
# rd = gts.select{|x| x != 'kwb' && !x.match?(/z\d+/)}.sample(6)
# gt1 = rd[0]
# gt2 = rd[1]
# gt3 = rd[2]
# gt4 = rd[3]
# gt5 = rd[4]
# gt6 = rd[5]
# gt7 = 'kwb'
# gt8 = 'z12'
# gt1 = rd[0]
# ar = []
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

# Etude du probleme sur z16
# gkw AND cmc -> z16

# composé de
# cgn OR nkh -> gkw (nkh unique et si on le swap ca casse avant)
# x16 XOR y16 -> cmc CEST BIEN LE TRUC QUI PREND X16 ET Y16

# étude de gkw
# crj AND kfw -> cgn c'est la combi prenant semblable a z(i-1)
# x15 AND y15 -> nkh C'est bien la combi juste x(i-1)y(i-1)

# sachant que z15 =
# kfw XOR crj -> z15

# La structure est bonne et ca marche en z15
# donc il faut modifier uniquement ce qui impacte 16
# celui qui fix : switch ces deux lignes
# gkw XOR cmc -> qkf
# gkw AND cmc -> z16

# on peut switch wwd et stj
# ttg ac bnk
# et stj ac pqw

# si on switch bnk et stj
# et ttg et hfh

# stj et ttg


# si je swap ttg et wwd
# et vhm et stj

# swap stj et wwd

# Etude du probleme sur z24

# vhm OR wwd -> z24
# x24 AND y24 -> wwd attendu
# ttg AND stj -> vhm combinaison semblable z23, x23, y23

# composé de

# bnk & un truc x23,y23
# dinguerie: swap z23 et bnk ET hgh et pqw

# composés de
# bnk OR pqw -> ttg
# x24 XOR y24 -> stj PAS VALIDE CA, TEST DE SWITCH AC x23 y23

# x23 y 23
# x23 AND y23 -> pqw celui ci ne pete pas 23 mais ne fixe pas 24
# y23 XOR x23 -> hfh

# sachant que
# hfh XOR sps -> z23
# sps AND hfh -> bnk

# il faudrait swich aussi ttg et bnk

# Etude du probleme en z29
# rwq XOR jqn -> z29

# htg OR gjq -> rwq
# x29 AND y29 -> jqn VALIDE
# x29 XOR y29 -> cph try de switch ca

# x28 AND y28 -> htg
# wws AND dsh -> gjq

# dsh XOR wws -> z28

# Etape 25
# skh XOR tgr -> z25
# x25 XOR y25 -> skh


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
    # gt1 = 'stj'
    # gt2 = 'wwd'
    # gt3 = 'z16'
    # gt4 = 'qkf'
    # gt5 = 'jqn'
    # gt6 = 'cph'
    # gt7 = 'z24'
    # gt8 = 'vhm'
q = ins.map{|x| x}
q.map! do |l|
  # if l.split(' ').last == 'z12'
  #   l.gsub('z12', 'kwb')
  # elsif l.split(' ').last == 'kwb'
  #   l.gsub('kwb', 'z12')
  # ttg ac bnk
# et stj ac pqw
# %i(z16 qkf ttg bnk stj pqw jqn cph)
# # si on switch bnk et stj
# et ttg et hfh
# swap z23 et bnk ET hgh et pqw
# %i(z12 kwb z16 qkf z24 tgr jqn cph)
 if l.split(' ').last == 'z12'
    l.gsub('z12', 'kwb')
  elsif l.split(' ').last == 'kwb'
    l.gsub('kwb', 'z12')
  elsif l.split(' ').last == 'z16'
    l.gsub('z16', 'qkf')
  elsif l.split(' ').last == 'qkf'
    l.gsub('qkf', 'z16')
  elsif l.split(' ').last == 'z24'
    l.gsub('z24', 'tgr')
  elsif l.split(' ').last == 'tgr'
    l.gsub('tgr', 'z24')
  # elsif l.split(' ').last == 'stj'
  #   l.gsub('stj', 'wwd')
  # elsif l.split(' ').last == 'wwd'
  #   l.gsub('wwd', 'stj')
  elsif l.split(' ').last == 'jqn'
    l.gsub('jqn', 'cph')
  elsif l.split(' ').last == 'cph'
    l.gsub('cph', 'jqn')
  else
    l
  end
end

# WRONG CANDIDATES
# bnk,cph,jqn,qkf,stj,vhm,z16,z24 WRONG
# cph,jqn,qkf,stj,vhm,wwd,z16,z24 WRONG
# bnk,cph,jqn,pqw,qkf,stj,ttg,z16 WRONG

pa = {}
old_l = nil
while q.any?
  p "tut"
  # p q
  # p "tit"
  # break if old_l && q.length == old_l
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
        p "ERRORAA"
      end
      to_rem << i
    end
  end
  to_rem.reverse.each {|j| q.delete_at(j)}
end
gts = ins.map{|l| l.split(' ').last}.uniq
zs = zs = gts.select{|x| x.match?(/z\d+/)}.sort
p zs
p zs.map{|zzz| h[zzz]}
# return

x = h.keys.select{|c| c.match?(/x\d+/)}.sort_by{|c| c.gsub('x', '').to_i }.map{|y| h[y]}.reverse.join('').to_i(2)
y = h.keys.select{|c| c.match?(/y\d+/)}.sort_by{|c| c.gsub('y', '').to_i }.map{|y| h[y]}.reverse.join('').to_i(2)
z = h.keys.select{|c| c.match?(/z\d+/)}.sort_by{|c| c.gsub('z', '').to_i }.map{|y| h[y]}.reverse.join('').to_i(2)

p x + y
p z

xi = x.to_s(2)
yi = y.to_s(2)
zi = z.to_s(2)

xi.length.times do |k|
  xik = xi[-1-k..-1]
  yik = yi[-1-k..-1]
  zik = zi[-1-k..-1]
  sik = (xik.to_i(2) + yik.to_i(2)).to_s(2)
  while sik.length < zik.length
    sik = '0' + sik
  end
  next if sik[-1-k..-1] == zik
  p "Error"
  p k

  p xi[-1-k..-1]
  p yi[-1-k..-1]
  p sik

  # p (xi[-1-k..-1].to_i(2) + yi[-1-k..-1].to_i(2)).to_s(2)[-1-k..-1]
  p zi[-1-k..-1]
  return
end

if x + y == z
  p "OUAIS"
  # p [gt1, gt2, gt3, gt4, gt5, gt6, gt7, gt8].sort.join(',')
  return
end

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
