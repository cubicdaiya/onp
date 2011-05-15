/** 
 * This program is checked with node.js
 */ 

/**
 * The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"
 * by described by Sun Wu, Udi Manber and Gene Myers
*/

exports.Diff = function f(a, b)
{
    this.m = a.length;
    this.n = b.length;
    this.reverse  = false;
    if (this.m >= this.n) {
        var tmp = a;
        this.a  = b;
        this.b  = tmp;
        this.reverse = true;
    } else {
        this.a = a;
        this.b = b;
    }
    this.ed         = null;
    this.offset     = this.m + 1;
    this.path       = [];
    this.pathposi   = [];
    this.ses        = [];
    this.lcs        = "";
    this.SES_DELETE = -1;
    this.SES_COMMON = 0;
    this.SES_ADD    = 1;
}

exports.Diff.prototype.P = function (x, y, k) {
    this.x = x;
    this.y = y;
    this.k = k;
}

exports.Diff.prototype.seselem = function (elem, t) {
    this.elem = elem;
    this.t    = t;
}

exports.Diff.prototype.compose = function ()
{
    var delta, size, fp, p, r, epc;
    delta  = this.n - this.m;
    size   = this.m + this.n + 3;
    fp     = {};
    for (var i=0;i<size;++i) {
        fp[i] = -1;
        this.path[i] = -1;
    }
    p = -1;
    do {
        ++p;
        for (var k=-p;k<=delta-1;++k) {
            fp[k+this.offset] = this.snake(k, fp[k-1+this.offset]+1, fp[k+1+this.offset]);
        }
        for (var k=delta+p;k>=delta+1;--k) {
            fp[k+this.offset] = this.snake(k, fp[k-1+this.offset]+1, fp[k+1+this.offset]);
        }
        fp[delta+this.offset] = this.snake(delta, fp[delta-1+this.offset]+1, fp[delta+1+this.offset]);
    } while (fp[delta+this.offset] != this.n);

    this.ed = delta + 2 * p;

    r = this.path[delta+this.offset];

    epc  = [];
    while (r != -1) {
        epc[epc.length] = new this.P(this.pathposi[r].x, this.pathposi[r].y, null);
        r = this.pathposi[r].k;
    }
    this.recordseq(epc);
}

exports.Diff.prototype.getses = function ()
{
    return this.ses;
}

exports.Diff.prototype.recordseq = function (epc)
{
    var x_idx, y_idx, px_idx, py_idx;
    x_idx  = y_idx  = 1;
    px_idx = py_idx = 0;
    for (var i=epc.length-1;i>=0;--i) {
        while(px_idx < epc[i].x || py_idx < epc[i].y) {
            if (epc[i].y - epc[i].x > py_idx - px_idx) {
                if (this.reverse) {
                    this.ses[this.ses.length] = new this.seselem(this.b[py_idx], this.SES_DELETE);
                } else {
                    this.ses[this.ses.length] = new this.seselem(this.b[py_idx], this.SES_ADD);
                }
                ++y_idx;
                ++py_idx;
            } else if (epc[i].y - epc[i].x < py_idx - px_idx) {
                if (this.reverse) {
                    this.ses[this.ses.length] = new this.seselem(this.a[px_idx], this.SES_ADD);
                } else {
                    this.ses[this.ses.length] = new this.seselem(this.a[px_idx], this.SES_DELETE);
                }
                ++x_idx;
                ++px_idx;
            } else {
                this.ses[this.ses.length] = new this.seselem(this.a[px_idx], this.SES_COMMON);
                this.lcs += this.a[px_idx];
                ++x_idx;
                ++y_idx;
                ++px_idx;
                ++py_idx;
            }
        }
    }
}

exports.Diff.prototype.editdistance = function ()
{
    return this.ed;
}
    
exports.Diff.prototype.getlcs = function ()
{
    return this.lcs;
}
    
exports.Diff.prototype.snake = function (k, p, pp)
{
    var r, x, y;
    if (p > pp) {
        r = this.path[k-1+this.offset];
    } else {
        r = this.path[k+1+this.offset];
    }
 
    y = Math.max(p, pp);
    x = y - k;
    while (x < this.m && y < this.n && this.a[x] == this.b[y]) {
        ++x;
        ++y;
    }

    this.path[k+this.offset] = this.pathposi.length;
    this.pathposi[this.pathposi.length] = new this.P(x, y, r);
    return y;
}
