package main

import (
	"fmt"
	"github.com/go-git/go-git/v5"
	"os"
)

func main() {
	clone()
}

func Info(info string) {
	fmt.Println(info)
}

func CheckIfError(err error) {
	if err != nil {
		panic(err)
	}
}

func clone() {
	// ENV_KEY
	envKey := "Store"
	store, ok := os.LookupEnv(envKey)
	if !ok {
		fmt.Printf("%s not set, bye!\n", envKey)
		return
	}
	// Clone the given repository to the given directory
	Info("git clone https://github.com/go-git/go-git")

	_, err := git.PlainClone(store, false, &git.CloneOptions{
		URL:      "https://github.com/go-git/go-git",
		Progress: os.Stdout,
	})

	CheckIfError(err)
}
