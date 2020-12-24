import 'dart:collection';
import 'dart:math';

main() {
  var tmp = '186524973'.split('').map(int.parse).toList();
  //var tmp = '389125467'.split('').map(int.parse).toList();
  var cups = HashMap();

  for (var i = 10; i < 1000001; i++) {
    tmp.add(i);
  }

  var curr = tmp[0];
  for (var i = 0; i < tmp.length; i++) {
    cups[tmp[i]] = tmp[(i + 1) % tmp.length];
  }

  var a, b, c, dest;
  for (var i = 0; i < 10000000; i++) {
    a = cups[curr];
    b = cups[a];
    c = cups[b];

    dest = curr - 1 < 1 ? 1000000 : curr - 1;
    while ([a, b, c].contains(dest)) {
      dest = dest - 1;
      dest = dest < 1 ? 1000000 : dest;
    }

    cups[curr] = cups[c];
    curr = cups[c];
    cups[c] = cups[dest];
    cups[dest] = a;
  }

  print(cups[1]);
  print(cups[cups[1]]);
  print(cups[1] * cups[cups[1]]);
}