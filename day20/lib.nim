import sequtils, sugar, algorithm

proc toString(str: seq[char]): string =
  result = newStringOfCap(len(str))
  for ch in str:
    add(result, ch)

proc reverse*(s: string): string =
  result = newString(s.len)
  for i,c in s:
    result[s.high - i] = c

proc getEdges*(img: seq[string]): tuple[up: string, down: string, left: string, right: string] =
  return (
    up: img[0],
    down: img[len(img) - 1],
    left: toString(img.map(x => x[0])),
    right: toString(img.map(x => x[len(x) - 1])))

proc removeEdges*(img: seq[string]): seq[string] =
  var newImg = img
  newImg.delete(0)
  newImg.delete(len(newImg)-1)
  return newImg.map(x => x[1..^2])

proc flipImage*(img: seq[string], dir: bool): seq[string] =
  var img = img
  if dir == true: # vertical
    img.reverse()
  elif dir == false: # horizontal
    img = img.map(x => reverse(x))
  return img

proc flipEdges*(
  edges: tuple[up: int, down: int, left: int, right: int],
  dir: bool
): tuple[up: int, down: int, left: int, right: int] =
  var edges = edges
  var temp:int

  if dir == true: # horizontal
    temp = edges.up
    edges.up = edges.down
    edges.down = temp

  elif dir == false: # vertical
    temp = edges.left
    edges.left = edges.right
    edges.right = temp

  return edges

proc turnImage*(img: seq[string], dir: bool): seq[string] =
  var flip = img
  if dir == true: # 90 deg
    for y in 0..(len(img) - 1):
      for x in 0..(len(img[y]) - 1):
        flip[y][x] = img[(len(img[x]) - 1) - x][y]

  elif dir == false: # -90 deg
    for y in 0..(len(img) - 1):
      for x in 0..(len(img[y]) - 1):
        flip[y][x] = img[x][(len(img[y]) - 1) - y]

  return flip

proc turnEdges*(
  edges: tuple[up: int, down: int, left: int, right: int],
  dir: bool
): tuple[up: int, down: int, left: int, right: int] =
  var edges2 = edges
  if dir == true: # 90 deg
    edges2.up = edges.left
    edges2.right = edges.up
    edges2.down = edges.right
    edges2.left = edges.down

  elif dir == false: # -90 deg
    edges2.up = edges.right
    edges2.right = edges.down
    edges2.down = edges.left
    edges2.left = edges.up

  return edges2

proc findMonsters*(img: seq[string]):int =
  let snake = [
    "                  # ",
    "#    ##    ##    ###",
    " #  #  #  #  #  #   "
  ]

  let width = len(snake[0]) - 1
  var count = 0
  for y, row in img:
    for x, _ in row:
      let endPos = x + width
      if endPos < len(row) and y + 2 < len(img):
        let window = [
          img[y][x..endPos],
          img[y + 1][x..endPos],
          img[y + 2][x..endPos]
        ]

        var check = true
        for y2, sRow in snake:
          for x2, _ in sRow:
            if snake[y2][x2] == '#' and window[y2][x2] != '#':
              check = false

        if check == true:
          count += 1
  return count