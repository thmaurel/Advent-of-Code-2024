# I noticed the result array size increase with A
# so i did big steps to find the starting point of 16digits
# then I played with steps size to find where thé end of thé array was similar since its the less changing part
# at some point it made it (luckily?)
# this code only works for my input

def combo(op)
  case op
  when 0, 1, 2, 3
    return op
  when 4
    return @a
  when 5
    return @b
  when 6
    return @c
  when 7
    p "ERROR"
  end
end

def run(ins, op)
  # p "RUN"
  # p [ins, op]
  # p "a: #{@a}"
  # p "b: #{@b}"
  # p "c: #{@c}"
  case ins
  when 0
    # p combo(op)
    # p 2**(combo(op))
    # p @a
    @a = @a / (2 **combo(op)).to_i
  when 1
    xor = ''
    b = @b.to_s(2)
    c = op.to_s(2)
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
    @b = xor.to_i(2)
  when 2
    @b = combo(op) % 8
  when 3
    unless @a == 0
      return ['jump', op]
    end
  when 4
    xor = ''
    b = @b.to_s(2)
    c = @c.to_s(2)
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
    @b = xor.to_i(2)
  when 5
    @res << combo(op) % 8
    # print (combo(op) % 8).to_s + ','
  when 6
    @b = @a / (2 **combo(op)).to_i
  when 7
    @c = @a / (2 **combo(op)).to_i
  end
end

# prog.each_slice(2) do |ins, op|
#   run(ins, op)
# end

# i = 0

1000000000.times do |a|
  # @a =  2024

  # prog = [ 0,3,5,4,3,0]
  # @a = 1_000_000_000*a + 26_292_544_621_820
  # @a = 3215*a + 35_182_544_621_821


  # 46_667_544_621_820

                  #trop 331_422_544_621_820
  # @a = a + 257391755731820
  #  @a = 2000*a + 258400232771820
  # @a = 200*a + 258400652771820
  # @a = 100*a + 258400667566020
  # @a = 1532131*a + 258400917566021
  # @a = 11*a + 267265150025734
  @a = a + 267265166221823
          #  267265148833870
  p @a
  # entre 258400717566020 et 258400718656020 ya R
  # @a = 1000*a + 258401337566020 on perd le 1
  # p @a if a % 10000 == 0
  # @a = 10000*a + 279890604621820
  @b = 0
  @c = 0
  prog = [2,4,1,7,7,5,0,3,4,4,1,7,5,5,3, 0]
  i = 0
  @res = []
  while i < prog.length
    go = run(prog[i], prog[i + 1])
    if go.is_a?(Array) && go.first == 'jump'
      i = go.last
    else
      i += 2
    end
  end
  # p "res"
  # p @res.length if a % 10000 == 0
  # p @res.last
  # return if @res.length == 16

  p @res #if a % 10000 == 0
  # p "YO" && return if [7,7,5,0,3,4, 4, 1, 7, 5, 5, 3, 0] == @res[3..15]
  if @res == prog
    p a + 267265166221823
    return
  end
end
