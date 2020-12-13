#!/bin/bash

function product_of_moduli () {
  arr=$2
  Ni=1
  for mod in ${arr[@]}; do
    if [[ "$mod" -ne "x" && "$mod" -ne "$1" ]]; then
      Ni=$(($Ni * $mod))
    fi
  done

  echo $Ni
}

function inverse_of_Ni () {
  cong=0
  Xi=-1
  while [ $cong != 1 ]; do
    Xi=$(($Xi + 1))
    cong=$(( ((($1 % $2) * $Xi) - $2) % $2 ))
  done

  echo $Xi
}

arr=($(echo "$(<resources/input)" | tr ',' '\n'))
arr=("${arr[@]:1}")

N=1
x=0
Bi=0
for mod in ${arr[@]}; do
  if [[ "$mod" -ne "x" ]]; then
    if [[ $Bi -ne 0 ]]; then
      Ni=$(product_of_moduli $mod ${arr})
      Xi=$(inverse_of_Ni $Ni $mod)
      x=$(($x + ($Bi * $Ni * $Xi)))
    fi
    N=$(($N * $mod))
  fi
  Bi=$(($Bi + 1))
done

echo $(($N - ($x % $N)))