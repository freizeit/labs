package main

import (
	"fmt"
   "net/http"
)

type String string

type SResponse struct {
   Greeting string
   Punct    string
   Who      string
}

func (s String) ServeHTTP(w http.ResponseWriter, r *http.Request) {
   fmt.Fprint(w, s)
}
func (s SResponse) ServeHTTP(w http.ResponseWriter, r *http.Request) {
   fmt.Fprint(w, s.Greeting, s.Punct, " ", s.Who)
}

func main() {
	http.Handle("/", String("Nothing to see here :)"))
	http.Handle("/string", String("I'm a frayed knot."))
	http.Handle("/struct", &SResponse{"Hello", ":", "Rackers!"})
   // your http.Handle calls here
   http.ListenAndServe("localhost:4000", nil)
}
