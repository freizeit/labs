package main

import (
    "strings"
    "code.google.com/p/go-tour/wc"
)

func WordCount(s string) map[string]int {
	result := make(map[string]int)
	for _, word := range(strings.Fields(s)) {
		result[word] += 1
	}
	return result
}

func main() {
    wc.Test(WordCount)
}
