
// The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"
// by described by Sun Wu, Udi Manber and Gene Myers

package onp

class Diff[T](_a: Array[T], _b: Array[T]) {

  private var a = _a
  private var b = _b
  private var m = _a.length
  private var n = _b.length

  def editdistance: Int = {
    if (m >= n) {
      val t1 = a
      val t2 = m
      a = b
      b = t1
      m = n
      n = t2
    }

    val offset:    Int = m + 1
    val delta:     Int = n - m
    val size:      Int = m + n + 3
    val fp: Array[Int] = new Array(size)
    var p:         Int = -1
    fp.map{x => -1}
    do {
      p = p + 1
      for (k <- (-p to delta) ) {
        fp(k + offset) = snake(k, fp(k - 1 + offset) + 1, fp(k + 1 + offset))
      }
      for (k <- (delta + p to delta).reverse) {
        fp(k + offset) = snake(k, fp(k - 1 + offset) + 1, fp(k + 1 + offset))
      }
      fp(delta + offset) = snake(delta, fp(delta - 1 + offset) + 1, fp(delta + 1 + offset))
    } while(fp(delta + offset) < n)
    delta + 2 * p
  }

  def snake(k: Int, p: Int, pp: Int):Int = {
    var y = scala.math.max(p, pp)
    var x = y - k
    while (x < m && y < n && a(x) == b(y)) {
      x = x + 1
      y = y + 1
    }
    y
  }
}
