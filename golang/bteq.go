package main

import (
	"fmt"
	"sort"
	"code.google.com/p/go-tour/tree"
)

// Walk walks the tree t sending all values
// from the tree to the channel ch.
func Walk(t *tree.Tree, ch chan int) {
	if t.Left != nil {
		Walk(t.Left, ch)
	}
	if t.Right != nil {
		Walk(t.Right, ch)
	}
	ch <- t.Value
}

// Compare returns an integer comparing the two byte slices,
// lexicographically.
// The result will be 0 if a == b, -1 if a < b, and +1 if a > b
func compare(a, b []int) int {
    for i := 0; i < len(a) && i < len(b); i++ {
        switch {
        case a[i] > b[i]:
            return 1
        case a[i] < b[i]:
            return -1
        }
    }
    switch {
    case len(a) < len(b):
        return -1
    case len(a) > len(b):
        return 1
    }
    return 0
}

// Same determines whether the trees
// t1 and t2 contain the same values.
func Same(t1, t2 *tree.Tree) bool {
	ch1 := make(chan int)
	ch2 := make(chan int)
	go func() {
		Walk(t1, ch1)
		close(ch1)
	} ()
	go func() {
		Walk(t2, ch2)
		close(ch2)
	} ()
	t1vals, t2vals := make([]int, 10), make([]int, 10)

	for i := 0; i < 10; i++ {
		if v1, ok := <-ch1; !ok {
			return false
		} else {
			t1vals[i] = v1
		}
		if v2, ok := <-ch2; !ok {
			return false
		} else {
			t2vals[i] = v2
		}
	}
	fmt.Printf("v1s = %#v\nv2s = %#v\n", t1vals, t2vals)
	sort.Ints(t1vals)
	sort.Ints(t2vals)
	return compare(t1vals, t2vals) == 0
}


func main() {
	ch1 := make(chan int)
	ch2 := make(chan int)
	go func() {
		Walk(tree.New(1), ch1)
		close(ch1)
	} ()
	go func() {
		Walk(tree.New(1), ch2)
		close(ch2)
	} ()

	for v := range(ch1) {
		fmt.Println(v)
	}
	fmt.Println("-----------")
	for v := range(ch2) {
		fmt.Println(v)
	}
	if tval := Same(tree.New(1), tree.New(1)); tval != true {
		fmt.Println("Oops! Something went wrong :(")
	} else {
		fmt.Println("The 2 trees are equal wrt values.")
	}
}

