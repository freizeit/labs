package main

import "code.google.com/p/go-tour/pic"

func Pic(dx, dy int) [][]uint8 {
	res := make([][]uint8, dy)
	for i := 0; i < dy; i++ {
		res[i] = make([]uint8, dx)
		for j := 0; j < dx; j++ {
			res[i][j] = uint8(i/2 + j*j)
		}
	}
	return res
}

func main() {
    pic.Show(Pic)
}
