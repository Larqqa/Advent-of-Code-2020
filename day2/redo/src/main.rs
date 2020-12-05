use std::fs::File;
use std::io::{prelude::*, BufReader};
use std::path::Path;
use std::time::Instant;

fn lines_from_file(filename: impl AsRef<Path>) -> Vec<String> {
    let file = File::open(filename).expect("no such file");
    let buf = BufReader::new(file);
    buf.lines()
        .map(|l| l.expect("Could not parse line"))
        .collect()
}

fn check_password(min: usize, max: usize, character: char, password: &str) -> bool {
    let mut password_length = 0;

    for p_char in password.chars() {
        if p_char == character {
            password_length += 1;
        }
    }

    if password_length >= min && password_length <= max {
        return true;
    } else {
        return false;
    }
}

fn check_password2(min: usize, max: usize, character: char, password: &str) -> bool {
    let min_char = password[min-1..min].chars().next().unwrap();
    let max_char = password[max-1..max].chars().next().unwrap();

    if min_char == max_char {
        return false
    } else if min_char == character {
        return true
    } else if max_char == character {
        return true
    } else {
        return false
    }
}

fn main() {
    let now = Instant::now();

    let lines = lines_from_file("../input.txt");
    let mut count = 0;
    for line in lines {
        let char_vec: Vec<&str> = line.split(' ').collect();

        let character = char_vec[1].replace(":", "").chars().next().unwrap();
        let password = char_vec[2];

        let limits: Vec<&str>= char_vec[0].split('-').collect();
        let min: usize = limits[0].parse::<usize>().unwrap();
        let max: usize = limits[1].parse::<usize>().unwrap();

        if check_password(min, max, character, password) {
            count += 1;
        }
    }
    println!("{}", count);

    println!("{:.2?}", now.elapsed());

    let now = Instant::now();

    let lines = lines_from_file("../input.txt");
    let mut count = 0;
    for line in lines {
        let char_vec: Vec<&str> = line.split(' ').collect();

        let password = char_vec[2];
        let character = char_vec[1].replace(":", "").chars().next().unwrap();

        let limits: Vec<&str>= char_vec[0].split('-').collect();
        let min: usize = limits[0].parse::<usize>().unwrap();
        let max: usize = limits[1].parse::<usize>().unwrap();

        if check_password2(min, max, character, password) {
            count += 1;
        }
    }
    println!("{}", count);

    println!("{:.2?}", now.elapsed());
}
