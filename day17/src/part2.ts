const input =
`....###.
#...####
##.#.###
..#.#...
##.#.#.#
#.######
..#..#.#
######.#`;

// const input =
// `.#.
// ..#
// ###`;

function crdToStr(x: number, y: number, z: number, w: number) {
  return `${x},${y},${z},${w}`;
}

function strToCrd(str: string) {
  return str.split(',').map(n => parseInt(n));
}

function checkAdjacent(x: number, y: number, z: number, w: number, recurse: boolean) {
  let sum = 0;

  for (let xx = x - 1; xx <= x + 1; xx++) {
    for (let yy = y - 1; yy <= y + 1; yy++) {
      for (let zz = z - 1; zz <= z + 1; zz++) {
        for (let ww = w - 1; ww <= w + 1; ww++) {
          if (xx === x && yy === y && zz === z && ww === w) {
            continue;
          } else if (active.has(crdToStr(xx, yy, zz, ww))) {
            sum++;
          } else if (recurse) {
            if (checkAdjacent(xx, yy, zz, ww, false) === 3) {
              tmp.add(crdToStr(xx, yy, zz, ww))
            }
          }
        }
      }
    }
  }

  return sum;
}

let active: Set<string> = new Set();
let tmp: Set<string> = new Set();

for (let [y, r] of input.split('\n').entries()) {
  for (let [x, c] of r.split('').entries()) {
    if (c === "#") active.add(crdToStr(x, y, 0, 0));
  }
}

for (let i = 0; i < 6; i++) {
  tmp = new Set();

  for (let ad of active) {
    let p = strToCrd(ad);
    let active = checkAdjacent(p[0], p[1], p[2], p[3], true);

    if (active != 2 && active != 3) {
      tmp.delete(ad);
    } else {
      tmp.add(ad);
    }
  }

  active = tmp;
}

console.log(active.size);

export{};
