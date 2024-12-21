NUM_NBS = {
  'A' => [['0', '<'], ['3', '^']],
  '0' => [['A', '>'], ['2', '^']],
  '1' => [['2', '>'], ['4', '^']],
  '2' => [['1', '<'], ['3', '>'], ['5', '^'], ['0', 'v']],
  '3' => [['2', '<'], ['6', '^'], ['A', 'v']],
  '4' => [['5', '>'], ['7', '^'], ['1', 'v']],
  '5' => [['4', '<'], ['6', '>'], ['8', '^'], ['2', 'v']],
  '6' => [['5', '<'], ['9', '^'], ['3', 'v']],
  '7' => [['8', '>'], ['4', 'v']],
  '8' => [['7', '<'], ['9', '>'], ['5', 'v']],
  '9' => [['8', '<'], ['6', 'v']]
}

DIR_NBS = {
  '<' => [['v', '>']],
  'v' => [['<', '<'], ['>', '>'], ['^', '^']],
  '>' => [['v', '<'], ['A', '^']],
  '^' => [['v', 'v'], ['A', '>']],
  'A' => [['^', '<'], ['>', 'v']]
}

CACHE = {}

def ins_for(str, nbs)
  s = 'A'
  e = str[0]
  str.length.times.map do |i|
    qs = ['', s]
    q = [qs]
    dis = nil
    re = []
    while f = q.shift
      dis = f.first.length if f.last == e
      re << f.first + 'A' if f.last == e && (re.empty? || re.first.length - 1 == f.first.length)
      nbs[f.last].each {|nb| q << [f.first + nb.last, nb.first] if dis.nil? || (f.first + nb.last).length <= dis }
    end
    s = e
    e = str[i + 1]
    re
  end
end

def shortest_path(str, n, max, keypad: NUM_NBS)
  CACHE[[str, n, max]] ||= ins_for(str, keypad).map { |insts| insts.map { |inst| n < max ? shortest_path(inst, n + 1, max, keypad: DIR_NBS) : inst.length }.min}.sum
end

d = open('data/data_21.txt').read.split("\n")
res = d.map {|cd| [shortest_path(cd, 0, 2) * cd.gsub('A', '').to_i, shortest_path(cd, 0, 25) * cd.gsub('A', '').to_i]}
puts "Part1: #{res.map(&:first).sum}\nPart2: #{res.map(&:last).sum}"
