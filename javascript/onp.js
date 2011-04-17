/**
 * The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"
 * by described by Sun Wu, Udi Manber and Gene Myers
*/

function Diff(a, b) {
    this.m = a.length;
    this.n = b.length;
    if (this.m >= this.n) {
	var tmp = this.a;
        this.a  = b;
        this.b  = tmp;
    } else {
        this.a  = a;
        this.b  = b;
    }
}

Diff.prototype.editdistance = function () {
    var offset, delta, size, fp, p;
    offset = this.m + 1;
    delta  = this.n - this.m;
    size   = this.m + this.n + 3;
    fp     = {};
    for (var i=0;i<size;++i) {
        fp[i] = -1;
    }
    p = -1;
    do {
        p = p + 1;
        for (var k=-p;k<=delta-1;++k) {
            fp[k+offset] = this.snake(k, fp[k-1+offset]+1, fp[k+1+offset]);
        }
        for (var k=delta+p;k>=delta+1;--k) {
            fp[k+offset] = this.snake(k, fp[k-1+offset]+1, fp[k+1+offset]);
        }
        fp[delta+offset] = this.snake(delta, fp[delta-1+offset]+1, fp[delta+1+offset]);
    } while (fp[delta+offset] != this.n);
    return delta + 2 * p;
}
    
Diff.prototype.snake = function (k, p, pp) {
    y = Math.max(p, pp);
    x = y - k;
    while (x < this.m && y < this.n && this.a[x] == this.b[y]) {
        ++x;
        ++y;
    }
    return y;
}

if (arguments.lengh < 2) {
    print("few arguments")
    exit()
}

var diff = new Diff(arguments[0], arguments[1]);
print(diff.editdistance());
