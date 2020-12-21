import strutils, sequtils, sugar

proc toString(str: seq[char]): string =
  result = newStringOfCap(len(str))
  for ch in str:
    add(result, ch)

proc reverse(s: string): string =
  result = newString(s.len)
  for i,c in s:
    result[s.high - i] = c

proc parseImg(img: seq[string]): tuple[up: string, down: string, left: string, right: string] =
  return (
    up: img[0],
    down: img[len(img) - 1],
    left: toString(img.map(x => x[0])),
    right: toString(img.map(x => x[len(x) - 1]))
  )

let input = readFile("resources/input")
  .split("\n\n")
  .map(x => x.split(":\n"))
  .map(x => (
    id: parseInt(x[0].split(" ")[1]),
    img: parseImg(x[1].split("\n"))
  ))

var sum = 1
for cam in input:
  var count = 0
  for dir in cam.img.fields:
    for cam2 in input:
      if cam.id != cam2.id:
        for dir2 in cam2.img.fields:
          if dir == dir2 or reverse(dir) == reverse(dir2):
            count += 1
          if dir == reverse(dir2) or reverse(dir) == dir2:
            count += 1
  if count == 2:
    sum *= cam.id

echo sum