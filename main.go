package main

import (
	"encoding/json"
	"html/template"
	"log"
	"net/http"
	"os"
	"strconv"
	"time"

	"github.com/gobuffalo/packr"
	"github.com/gorilla/mux"
)

var (
	sha1      string // sha1 revision used to build the program
	buildTime string // when the executable was built

	js   []byte
	err  error
	html string
)

type Health struct {
	Version   string
	BuildTime string
}

func main() {

	log.Println("Starting foo app.")

	log.Printf("Built on %s from sha1 %s\n", buildTime, sha1)

	box := packr.NewBox("./assets")
	html = box.String("index.html")

	r := mux.NewRouter()
	r.HandleFunc("/_hc", HealthCheckHandler)
	r.HandleFunc("/", Root)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	srv := &http.Server{
		Handler:      r,
		Addr:         "0.0.0.0:" + port,
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(srv.ListenAndServe())

}

func Root(w http.ResponseWriter, req *http.Request) {

	template, err := template.New("name").Parse(html)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	template.Execute(w, nil)
}

// health check...
func HealthCheckHandler(w http.ResponseWriter, req *http.Request) {

	health := Health{sha1, buildTime}

	js, err = json.Marshal(health)

	if err != nil {
		log.Println("Error")
		log.Println(err)
	}

	serveJSON(w, js)
}

func servePlainText(w http.ResponseWriter, s string) {
	w.Header().Set("Content-Type", "text/plain")
	w.Header().Set("Content-Length", strconv.Itoa(len(s)))
	w.WriteHeader(http.StatusOK)
	w.Write([]byte(s))
}

func serveJSON(w http.ResponseWriter, js []byte) {

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(js)

}
