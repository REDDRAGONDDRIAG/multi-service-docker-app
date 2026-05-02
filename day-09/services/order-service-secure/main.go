package main

import (
    "fmt"
    "log"
    "net/http"
    "os"
)

func healthHandler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(http.StatusOK)
    fmt.Fprintf(w, `{"status":"healthy","service":"order-service"}`)
}

func rootHandler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(http.StatusOK)
    fmt.Fprintf(w, `{"service":"order-service","version":"1.0"}`)
}

func listOrdersHandler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(http.StatusOK)
    fmt.Fprintf(w, `{"orders":[{"id":1,"user":"john","total":99.99},{"id":2,"user":"jane","total":49.99}]}`)
}

func createOrderHandler(w http.ResponseWriter, r *http.Request) {
    if r.Method != http.MethodPost {
        w.WriteHeader(http.StatusMethodNotAllowed)
        return
    }
    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(http.StatusCreated)
    fmt.Fprintf(w, `{"id":3,"status":"created"}`)
}

func main() {
    http.HandleFunc("/", rootHandler)
    http.HandleFunc("/health", healthHandler)
    http.HandleFunc("/orders", func(w http.ResponseWriter, r *http.Request) {
        if r.Method == http.MethodPost {
            createOrderHandler(w, r)
        } else {
            listOrdersHandler(w, r)
        }
    })

    port := os.Getenv("PORT")
    if port == "" {
        port = "3003"
    }

    addr := fmt.Sprintf(":%s", port)
    log.Printf("🚀 Order service on %s\n", addr)

    if err := http.ListenAndServe(addr, nil); err != nil {
        log.Fatalf("Server error: %v\n", err)
    }
}
