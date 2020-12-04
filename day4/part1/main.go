package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strconv"
	"strings"
	"time"
)

func handleErrors(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

// Passport is to make a passport
type Passport struct {
	byr int
	iyr int
	eyr int
	hgt string
	hcl string
	ecl string
	pid string
	cid string
}

func main() {
	start := time.Now()

	input, err := ioutil.ReadFile("input.txt")
	handleErrors(err)

	passports := strings.Split(string(input), "\n\n")

	count := 0
	for _, passport := range passports {
		passport = strings.ReplaceAll(passport, "\n", " ") // Sanitize to single line
		passportInfo := strings.Split(passport, " ")       // Separate fields

		passportObj := makePassport(passportInfo)
		// fmt.Println(passportObj)
		if validatePassport(passportObj) {
			count++
		}
	}

	fmt.Println(count)

	elapsed := time.Since(start)
	log.Printf("Time: %s", elapsed)
}

func makePassport(content []string) Passport {
	p := Passport{}
	var err error

	for _, passport := range content {
		tmp := strings.Split(passport, ":")
		key, value := tmp[0], tmp[1]

		switch key {
		case "byr":
			if value == "" {
				p.byr = 0
			} else {
				p.byr, err = strconv.Atoi(value)
				handleErrors(err)
			}

		case "iyr":
			if value == "" {
				p.iyr = 0
			} else {
				p.iyr, err = strconv.Atoi(value)
				handleErrors(err)
			}

		case "eyr":
			if value == "" {
				p.eyr = 0
			} else {
				p.eyr, err = strconv.Atoi(value)
				handleErrors(err)
			}

		case "hgt":
			p.hgt = value

		case "hcl":
			p.hcl = value

		case "ecl":
			p.ecl = value

		case "pid":
			p.pid = value

		case "cid":
			p.cid = value
		}
	}

	return p
}

func validatePassport(passport Passport) bool {
	if passport.byr != 0 &&
		passport.iyr != 0 &&
		passport.eyr != 0 &&
		passport.hgt != "" &&
		passport.hcl != "" &&
		passport.ecl != "" &&
		passport.pid != "" {
		return true
	}
	return false
}
