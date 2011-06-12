/** 
 * This program is checked with node.js
 */ 

/**
 * The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"
 * by described by Sun Wu, Udi Manber and Gene Myers
*/

exports.Diff = function (a_, b_) {
    var a          = a_,
        b          = b_,
        m          = a.length,
        n          = b.length,
        reverse    = false,
        ed         = null,
        offset     = m + 1,
        path       = [],
        pathposi   = [],
        ses        = [],
        lcs        = "",
        SES_DELETE = -1,
        SES_COMMON = 0,
        SES_ADD    = 1;

    init();

    function init () {
        if (m >= n) {
            var tmp1 = a;
            var tmp2 = m;
            a        = b;
            b        = tmp1;
            m        = n;
            n        = tmp2;
            reverse  = true;
        }
    }

    function P (x, y, k) {
        return {
            'x' : x,
            'y' : y,
            'k' : k,
        };
    }

    function seselem (elem, t) {
        return {
            'elem' : elem,
            't'    : t,
        }
    }

    function snake (k, p, pp) {
        var r, x, y;
        if (p > pp) {
            r = path[k-1+offset];
        } else {
            r = path[k+1+offset];
        }
        
        y = Math.max(p, pp);
        x = y - k;
        while (x < m && y < n && a[x] == b[y]) {
            ++x;
            ++y;
        }
        
        path[k+offset] = pathposi.length;
        pathposi[pathposi.length] = new P(x, y, r);
        return y;
    }

    function recordseq (epc) {
        var x_idx, y_idx, px_idx, py_idx;
        x_idx  = y_idx  = 1;
        px_idx = py_idx = 0;
        for (var i=epc.length-1;i>=0;--i) {
            while(px_idx < epc[i].x || py_idx < epc[i].y) {
                if (epc[i].y - epc[i].x > py_idx - px_idx) {
                    if (reverse) {
                        ses[ses.length] = new seselem(b[py_idx], SES_DELETE);
                    } else {
                        ses[ses.length] = new seselem(b[py_idx], SES_ADD);
                    }
                    ++y_idx;
                    ++py_idx;
                } else if (epc[i].y - epc[i].x < py_idx - px_idx) {
                    if (reverse) {
                        ses[ses.length] = new seselem(a[px_idx], SES_ADD);
                    } else {
                        ses[ses.length] = new seselem(a[px_idx], SES_DELETE);
                    }
                    ++x_idx;
                    ++px_idx;
                } else {
                    ses[ses.length] = new seselem(a[px_idx], SES_COMMON);
                    lcs += a[px_idx];
                    ++x_idx;
                    ++y_idx;
                    ++px_idx;
                    ++py_idx;
                }
            }
        }
    }
    
    return {
        SES_DELETE : -1,
        SES_COMMON :  0,
        SES_ADD    :  1,
        editdistance : function () {
            return ed;
        },
        getlcs : function () {
            return lcs;
        },
        getses : function () {
            return ses;
        },
        compose : function () {
            var delta, size, fp, p, r, epc;
            delta  = n - m;
            size   = m + n + 3;
            fp     = {};
            for (var i=0;i<size;++i) {
                fp[i] = -1;
                path[i] = -1;
            }
            p = -1;
            do {
                ++p;
                for (var k=-p;k<=delta-1;++k) {
                    fp[k+offset] = snake(k, fp[k-1+offset]+1, fp[k+1+offset]);
                }
                for (var k=delta+p;k>=delta+1;--k) {
                    fp[k+offset] = snake(k, fp[k-1+offset]+1, fp[k+1+offset]);
                }
                fp[delta+offset] = snake(delta, fp[delta-1+offset]+1, fp[delta+1+offset]);
            } while (fp[delta+offset] != n);
            
            ed = delta + 2 * p;
            
            r = path[delta+offset];
            
            epc  = [];
            while (r != -1) {
                epc[epc.length] = new P(pathposi[r].x, pathposi[r].y, null);
                r = pathposi[r].k;
            }
            recordseq(epc);
        },
    };
};
