package onp

import (
        "testing"
)

func TestEditDistance(t *testing.T) {
        str1 := "hoge"
        str2 := "hogehoge"

        diff := NewDiff(str1, str2)
        editDistance := diff.EditDistance()
        if editDistance != 4 {
                t.Errorf("Expect 4 but actual %d", editDistance)
        }
}
