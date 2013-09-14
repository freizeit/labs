package main

import (
    "fmt"
    "math"
)

var precision = 1e-05

type ErrNegativeSqrt float64
func (e ErrNegativeSqrt) Error() string {
	return fmt.Sprintf("cannot Sqrt negative number: %v", float64(e))
}

func Sqrt(x float64) (float64, error) {
	if x < 0 {
		return 0, ErrNegativeSqrt(x)
	}
	// https://de.wikipedia.org/wiki/Babylonisches_Wurzelziehen
	iters := 0
	z := (x + 1)/2
	for {
		iters++
		z2 := (z + (x/z))/2
		delta := math.Abs(z2 - z)
		z = z2
		if delta < precision {
			break
		}
	}
	return z, nil
}

func main() {
    fmt.Println(Sqrt(2))
    fmt.Println(Sqrt(-2))
}
