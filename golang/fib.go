package main

import "fmt"

// fibonacci is a function that returns
// a function that returns an int.
func fibonacci() func() int {
	pval := []int{0,-1}
	return func() int {
		fib := pval[0] + pval[1]
		if fib < 1 {
			fib += 1
		}
		pval[1] = pval[0]
		pval[0] = fib
		return fib
	}
}

func main() {
    f := fibonacci()
    for i := 0; i < 10; i++ {
        fmt.Println(f())
    }
}
