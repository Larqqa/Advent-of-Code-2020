type public_key = {
  key: int,
  mutable loop: int,
};

let door: public_key = {
  key: 17607508,
  loop: 0
};
let card: public_key = {
  key: 15065270,
  loop: 0
};

/*
let door: public_key = {
  key: 17807724,
  loop: 11
};
let card: public_key = {
  key: 5764801,
  loop: 8
};
*/

let getLoopCount = (key) => {
  let value = ref(1);
  let loops = ref(0);

  while (value^ != key) {
    value := (value^ * 7) mod 20201227;
    loops := loops^ + 1;
  }

  loops^;
};

let transform = (subj, loop) => {
  let value = ref(1.0);
  let subj = float_of_int(subj);

  for (_ in 0 to loop - 1) {
    value := mod_float((value^ *. subj), 20201227.0);
  }

  int_of_float(value^);
};

door.loop = getLoopCount(door.key);
card.loop = getLoopCount(card.key);

print_int(transform(door.key, card.loop));
print_newline();
