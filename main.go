package main

import (
	"fmt"
	"time"
)

// BuildValue is injected at build time via -ldflags.
var BuildValue string

func main() {
	fmt.Println(BuildValue)
	// Sleep indefinitely to keep the container running.
	for {
		time.Sleep(24 * time.Hour)
	}
}
