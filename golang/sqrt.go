package main

import (
    "fmt"
    "math"
)

var precision = 1e-05

func Sqrt(x float64) float64 {
	iters := 0
	z := x/2
	for {
		iters++
		z2 := z - ((z * z - x) / 2 * z)
		delta := math.Abs(z2 - z)
		z = z2
		if delta < precision {
			delta = math.Abs(math.Sqrt(x) - z)
			fmt.Println(z)
			fmt.Println(iters)
			fmt.Println(delta)
			break
		}
	}
	return z
}

func Heron(x float64) float64 {
	// https://de.wikipedia.org/wiki/Babylonisches_Wurzelziehen
	iters := 0
	z := (x + 1)/2
	for {
		iters++
		z2 := (z + (x/z))/2
		delta := math.Abs(z2 - z)
		z = z2
		if delta < precision {
			fmt.Println("Heron: ", z)
			fmt.Println("Iters: ", iters)
			fmt.Println("Delta: ", delta)
			break
		}
	}
	return z
}

func main() {
	fmt.Println(precision)
	fmt.Println("Sqrt:  ", math.Sqrt(2))
   Heron(2)
}
