/** 
 * This program is checked with node.js
 */ 

var onp = require('./onp.js');

var diff = new onp.Diff(process.argv[2], process.argv[3]);
diff.compose();
console.log("editdistance:" + diff.editdistance());
console.log("lcs:" + diff.getlcs());
console.log("ses");

var i   = 0;
var ses = diff.getses();
for (i=0;i<ses.length;++i) {
    if (ses[i].t === diff.SES_COMMON) {
        console.log(" " + ses[i].elem);
    } else if (ses[i].t === diff.SES_DELETE) {
        console.log("-" + ses[i].elem);
    } else if (ses[i].t === diff.SES_ADD) {
        console.log("+" + ses[i].elem);
    }
}
