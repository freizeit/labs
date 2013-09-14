package main

import (
    "code.google.com/p/go-tour/pic"
    "image"
    "image/color"
)

type Image struct{}

func (i Image) ColorModel() color.Model {
	return color.RGBAModel
}

func (i Image) Bounds() image.Rectangle {
	return image.Rectangle{image.Point{0,0}, image.Point{9,9}}
}

func (i Image) At(x, y int) color.Color {
	v := uint8(x/2 + y*y)
	return color.RGBA{v, v, 255, 255}
}

func main() {
    m := Image{}
    pic.ShowImage(m)
}
