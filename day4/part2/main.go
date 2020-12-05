package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"regexp"
	"strconv"
	"strings"
)

// Height is used to make a hight
type Height struct {
	metric string
	amount int
}

// Passport is to make a passport
type Passport struct {
	byr int
	iyr int
	eyr int
	hgt Height
	hcl string
	ecl string
	pid string
	cid string
}

func main() {
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
}

func makePassport(content []string) Passport {
	p := Passport{}
	var err error

	for _, passport := range content {
		tmp := strings.Split(passport, ":")
		key, value := tmp[0], tmp[1]

		switch key {
		case "byr":
			p.byr = convertStringToInt(value)

		case "iyr":
			p.iyr = convertStringToInt(value)

		case "eyr":
			p.eyr = convertStringToInt(value)

		case "hgt":
			if value == "" {
				p.hgt = Height{}
			} else {
				s := []rune(value)
				offset := len(value) - 2
				metric := string(s[offset:])

				if metric != "cm" && metric != "in" {
					metric = ""
				}

				tmp := string(s[:offset])
				amount := 0

				if tmp != "" {
					amount, err = strconv.Atoi(tmp)
					handleErrors(err)
				}

				p.hgt = Height{metric: metric, amount: amount}
			}

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
	if passport.byr >= 1920 && passport.byr <= 2002 &&
		passport.iyr >= 2010 && passport.iyr <= 2020 &&
		passport.eyr >= 2020 && passport.eyr <= 2030 &&
		validateEyeColor(passport.ecl) &&
		validatePID(passport.pid) &&
		validateHairColor(passport.hcl) &&
		validateHeight(passport.hgt.metric, passport.hgt.amount) {
		return true
	}

	return false
}

func validatePID(pid string) bool {
	if len(pid) == 9 {
		Regex := regexp.MustCompile("[0-9]")
		if Regex.Match([]byte(pid)) {
			return true
		}
	}

	return false
}

func validateEyeColor(color string) bool {
	if color == "amb" ||
		color == "blu" ||
		color == "brn" ||
		color == "gry" ||
		color == "grn" ||
		color == "hzl" ||
		color == "oth" {
		return true
	}

	return false
}

func validateHairColor(color string) bool {
	if len(color) == 7 && string(color[0]) == "#" {
		Regex := regexp.MustCompile("[0-9a-f]")
		s := []rune(color)
		if Regex.Match([]byte(string(s[1:]))) {
			return true
		}
	}

	return false
}

func validateHeight(metric string, amount int) bool {
	if metric == "cm" {
		if amount >= 150 && amount <= 193 {
			return true
		}
	} else if metric == "in" {
		if amount >= 59 && amount <= 76 {
			return true
		}
	}

	return false
}

func convertStringToInt(str string) int {
	if str == "" {
		return 0
	}

	i, err := strconv.Atoi(str)
	handleErrors(err)
	return i
}

func handleErrors(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
