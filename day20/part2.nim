import strutils, sequtils, sugar, tables, math, algorithm

proc toString(str: seq[char]): string =
  result = newStringOfCap(len(str))
  for ch in str:
    add(result, ch)

proc reverse(s: string): string =
  result = newString(s.len)
  for i,c in s:
    result[s.high - i] = c

proc parseEdges(img: seq[string]): tuple[up: string, down: string, left: string, right: string] =
  return (
    up: img[0],
    down: img[len(img) - 1],
    left: toString(img.map(x => x[0])),
    right: toString(img.map(x => x[len(x) - 1])))

proc removeEdges(img: string): seq[string] =
  var newImg = img.split("\n")
  newImg.delete(0)
  newImg.delete(len(newImg) - 1)
  return newImg.map(x => x[1..^2])

proc flipImage(img: seq[string], dir: bool): seq[string] =
  var img = img
  if dir == true:
    img = img.map(x => reverse(x))
  elif dir == false:
    img.reverse()
  img

# WIP
proc turnImage(img: seq[string], dir: bool): seq[string] =
  var img = img
  if dir == true:
    img = img.map(x => reverse(x))
  elif dir == false:
    img.reverse()
  img

var input = initTable[int, seq[string]]()

const lines = readFile("resources/training")
  .split("\n\n")
  .map(x => x.split(":\n"))

for line in lines:
  input[parseInt(line[0].split(" ")[1])] = line[1].split("\n")

echo input[1951]
echo flipImage(input[1951], false)

for idx, img in input:
  var edges = parseEdges(img)
  echo edges

