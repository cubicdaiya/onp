
function editdistance(a, b) {
    var m, n, offset, delta, size, fp, p;
    m = a.length;
    n = b.length;
    if (m >= n) {
	var tmp;
	tmp = a;
	a   = b;
        b   = tmp;
    }
    offset = m + 1;
    delta  = n - m;
    size   = m + n + 3;
    fp     = {};
    for (var i=0;i<size;++i) {
        fp[i] = -1;
    }
    p = -1;
    do {
        p = p + 1;
        for (var k=-p;k<=delta-1;++k) {
            fp[k+offset] = snake(a, b, m, n, k, fp[k-1+offset]+1, fp[k+1+offset]);
        }
        for (var k=delta+p;k>=delta+1;--k) {
            fp[k+offset] = snake(a, b, m, n, k, fp[k-1+offset]+1, fp[k+1+offset]);
        }
        fp[delta+offset] = snake(a, b, m, n, delta, fp[delta-1+offset]+1, fp[delta+1+offset]);
    } while (fp[delta+offset] != n);
    return delta + 2 * p
}
    
function snake(a, b, m, n, k, p, pp) {
    y = Math.max(p, pp);
    x = y - k;
    while (x < m && y < n && a[x] == b[y]) {
        x = x + 1;
        y = y + 1;
    }
    return y;
}

if (arguments.lengh < 2) {
    print("few arguments")
    exit()
}

print(editdistance(arguments[0], arguments[1]))
