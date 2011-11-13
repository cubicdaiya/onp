import std.stdio;
import diff;

void main(string[] arg)
{
    diff.Diff!(char, string) d = new diff.Diff!(char, string)(arg[1], arg[2]);
    d.compose();
    printf("editdistance = %d\n", d.getEditDistance());
}
