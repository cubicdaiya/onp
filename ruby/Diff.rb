
=begin
The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"                                   
by described by Sun Wu, Udi Manber and Gene Myers 
=end

class Diff
  attr_reader :editdis
  def initialize(a, b)
    @a = a
    @b = b
    @m = a.length
    @n = b.length
    if @m > @n
      @a, @b = @b, @a
      @m, @n = @n, @m
    end
    @editdis = 0
  end
  def compose()
    offset = @m + 1
    delta  = @n - @m
    size   = @m + @m + 3
    fp     = Array.new(size){|i| -1}
    p      = -1
    begin
      p = p + 1
      (-p..delta-1).each do |k|
        fp[k+offset] = snake(k, fp[k-1+offset]+1, fp[k+1+offset])
      end
      (delta+p..delta+1).to_a.reverse.each do |k|
        fp[k+offset] = snake(k, fp[k-1+offset]+1, fp[k+1+offset])
      end
      fp[delta+offset] = snake(delta, fp[delta-1+offset]+1, fp[delta+1+offset])
    end while fp[delta+offset] != @n
    @editdis = delta + 2 * p
  end
  def snake(k, p, pp)
    y = [p, pp].max
    x = y - k
    while x < @m and y < @n and @a[x] == @b[y]
      x = x + 1
      y = y + 1
    end
    return y
  end
end
