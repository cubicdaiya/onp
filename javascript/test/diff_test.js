
var onp  = require('../onp.js');
var diff = new onp.Diff("abc", "abd");
diff.compose();

var correct_lcs = "ab";

var correct_ses = [
    { elem : 'a', t : 0 },
    { elem : 'b', t : 0 },
    { elem : 'c', t : -1 },
    { elem : 'd', t : 1 }
];

exports['editdistance'] =
    function (test) {
        test.equal(diff.editdistance(), 2);
    test.done();
    };

exports['lcs'] =
    function (test) {
        
        test.equal(diff.getlcs(), correct_lcs);
        test.done();
    };

exports['ses'] =
    function (test) {
        test.deepEqual(correct_ses, diff.getses());
    test.done();
    };

