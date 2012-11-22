package main

import (
        "os"
        "fmt"
        "./onp"
)

func main() {
	if len(os.Args) < 3 {
		fmt.Printf("set two args\n")
	} else {
            diff := onp.NewDiff(os.Args[1], os.Args[2])
		fmt.Printf("editdistance:%d\n",  diff.EditDistance())
	}
}
