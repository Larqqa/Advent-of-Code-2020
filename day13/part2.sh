#!/bin/bash

function divide_ceil () {
  echo $(( ($1 + $2 - 1) / $2))
}

arr=($(echo "$(<resources/input)" | tr ',' '\n'))
arr=("${arr[@]:1}")

N=1
x=0
i=0
for mod in ${arr[@]}; do
  if [[ "$mod" -ne "x" ]]; then
    if [[ $i -ne 0 ]]; then

      sum=1
      for mod2 in ${arr[@]}; do
        if [[ "$mod2" -ne "x" && "$mod2" -ne "$mod" ]]; then
          sum=$(($sum * $mod2))
        fi
      done

      tmp=$(($sum % $mod))
      cong=0
      iter=0
      while [ $cong != 1 ]; do
        cong=$(( (($tmp * $iter) - $mod) % $mod ))
        iter=$(($iter + 1))
      done
      iter=$(($iter - 1))

      x=$(($x + ($i * $sum * $iter)))

    fi
    N=$(($N * $mod))
  else
    unset -v 'arr[$i]'
  fi

  i=$(($i + 1))
done

echo $((N - ($x % $N)))