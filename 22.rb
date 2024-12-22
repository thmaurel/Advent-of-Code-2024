require_relative 'lib'

day = Date.today.day
year = Date.today.year

get_datas(day, year)

filename = "data_#{day}.txt"

d = lines(filename).map(&:to_i)
# d = lines_w_spaces(filename)
# d = matrix(filename)
# d = matrix_i(filename)

def s1(secret)
  s = secret * 64
  b = s.to_s(2)
  c = secret.to_s(2)
  xor = ''
  while b.length < c.length
    b = '0' + b
  end
  while b.length > c.length
    c = '0' + c
  end
  b.length.times do |k|
    if (b[k] == '1' && c[k] == '0') ||(c[k] == '1' && b[k] == '0')
      xor += '1'
    else
      xor += '0'
    end
  end
  d = xor.to_i(2)
  e = d % 16777216
end

def s2(secret)
  s = secret / 32
  b = s.to_s(2)
  c = secret.to_s(2)
  xor = ''
  while b.length < c.length
    b = '0' + b
  end
  while b.length > c.length
    c = '0' + c
  end
  b.length.times do |k|
    if (b[k] == '1' && c[k] == '0') ||(c[k] == '1' && b[k] == '0')
      xor += '1'
    else
      xor += '0'
    end
  end
  d = xor.to_i(2)
  e = d % 16777216
end

def s3(secret)
  s = secret * 2048
  b = s.to_s(2)
  c = secret.to_s(2)
  xor = ''
  while b.length < c.length
    b = '0' + b
  end
  while b.length > c.length
    c = '0' + c
  end
  b.length.times do |k|
    if (b[k] == '1' && c[k] == '0') ||(c[k] == '1' && b[k] == '0')
      xor += '1'
    else
      xor += '0'
    end
  end
  d = xor.to_i(2)
  e = d % 16777216
end

CACHE = {}

def se(s)
  CACHE[s] ||= s3(s2(s1(s)))
end

res = 0

seqs = {}
d.each_with_index do |l,i|
  p "#{i+1} / #{d.length}"
  s = l
  prs = []
  ins = []
  seqs[i] = {}
  2000.times do
    ins << s % 10 - prs.last if prs.any?
    prs << s % 10
    s = se(s)
  end
  res += s
  ins << s % 10 - prs.last if prs.any?
  prs << s % 10
  ins.each_with_index do |inst, j|
    next if j + 3 > ins.length - 1

    seq = [ins[j], ins[j + 1], ins[j + 2], ins[j + 3]]
    seqs[i][seq] = prs[j + 4] if seqs[i][seq].nil?
  end
end
pss = seqs.values.map{|h| h.keys}.flatten(1).uniq
pprs = pss.map do |ps|
  seqs.map do |k, seq|
    seq[ps] || 0
  end.sum
end
p "Part1: #{res}"
p "Part1: #{pprs.max}"
