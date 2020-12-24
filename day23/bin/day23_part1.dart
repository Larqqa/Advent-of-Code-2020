import 'dart:math';

main() {
  var cups = '186524973'.split('').map(int.parse).toList();
  // var cups = '389125467'.split('').map(int.parse).toList();

  var highest = cups.reduce(max);
  var selection, rest;
  var curr, dest, end, destInd, currInd, currNewInd, start;
  var pos = 0;
  var wrapAround = 0;
  var destFound = false;
  var offset = 0;

  for (var i = 0; i < 100; i++ ) {
    start = pos;
    curr = cups[start > cups.length ? start - cups.length : start];
    dest = curr - 1;
    end = start + 4 < cups.length ? start + 4 : cups.length;
    wrapAround = (start + 4) - cups.length;

    if (wrapAround > 0)  {
      selection = [...cups.sublist(start + 1, end), ...cups.sublist(0, wrapAround)];
    } else {
      selection = cups.sublist(start + 1, end);
    }

    destFound = false;
    while (!destFound) {
      if (selection.contains(dest)) {
        dest--;
      } else if (cups.contains(dest)) {
        destFound = true;
      } else if (dest <= 0) {
        dest = highest;
      }
    }

    rest = cups.where((v) => selection.contains(v) == false).toList();
    destInd = rest.indexOf(dest) + 1;
    currInd = cups.indexOf(curr);
    cups = [...rest.sublist(0, destInd), ...selection, ...rest.sublist(destInd, rest.length)];
    currNewInd = cups.indexOf(curr);
    offset = currNewInd - currInd;
    pos += offset;
    pos < cups.length - 1 ? pos++ : pos = 0;
  }

  var i = cups.indexOf(1);
  var tmp = [...cups.sublist(i + 1, cups.length), ...cups.sublist(0, i)];
  print(tmp.join());
}