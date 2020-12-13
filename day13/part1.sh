#!/bin/bash

function divide_ceil () {
  echo $(( ($1 + $2 - 1) / $2))
}

arr=($(echo "$(<resources/input)" | tr ',' '\n'))
timestamp=${arr[0]}
unset arr[0]

sum=0
bus=
smallest=

for i in ${arr[@]}; do
  if [[ "$i" -ne "x" ]]; then
    dif=$(divide_ceil $timestamp $i)
    comb=$(($i * $dif))

    if [[ ! $smallest || $comb < $smallest ]]; then
      bus=$i
      smallest=$comb
    fi
  fi
done

echo $(( $bus * ($smallest - $timestamp) ))