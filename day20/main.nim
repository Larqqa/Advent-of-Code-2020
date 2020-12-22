import strutils, sequtils, sugar, tables, math, lib

var input = initTable[int, tuple[
  img: seq[string],
  edges: tuple[up: int, down: int, left: int, right: int]
]]()

const lines = readFile("resources/input")
  .split("\n\n")
  .map(line => line.split(":\n"))

const size = int( sqrt( float( len(lines) ) ) )

for line in lines:
  input[parseInt(line[0].split(" ")[1])] = (
    img: line[1].split("\n"),
    edges: (up: 0, down: 0, left: 0, right: 0)
  )

# Find each piece's adjacent pieces
var multi = 1
var topLeft:int
for idx, camera in input:
  var edges = getEdges(camera.img)
  var count = 0
  for idx2, camera2 in input:
    if idx != idx2:
      var edges2 = getEdges(camera2.img)
      for edge in edges2.fields:
        if edges.up == edge or edges.up == reverse(edge):
          input[idx].edges.up = idx2
          count += 1

        if edges.down == edge or edges.down == reverse(edge):
          input[idx].edges.down = idx2
          count += 1

        if edges.left == edge or edges.left == reverse(edge):
          input[idx].edges.left = idx2
          count += 1

        if edges.right == edge or edges.right == reverse(edge):
          input[idx].edges.right = idx2
          count += 1
  if count == 2:
    topLeft = idx
    multi *= idx

# Fix orientation of the pieces
var map: array[size, array[size, int]]
map[0][0] = topLeft
for y, row in map:
  for x, _ in row:
    var ind = map[y][x]
    if ind > 0:
      var camera = input[ind]

      if y > 0:
        if map[y - 1][x] == camera.edges.right:
          input[ind].img = turnImage(camera.img, false)
          input[ind].edges = turnEdges(camera.edges, false)
          camera = input[ind]

        elif map[y - 1][x] == camera.edges.down:
          input[ind].img = flipImage(camera.img, true)
          input[ind].edges = flipEdges(camera.edges, true)
          camera = input[ind]

        elif map[y - 1][x] == camera.edges.left:
          input[ind].img = turnImage(camera.img, true)
          input[ind].edges = turnEdges(camera.edges, true)
          camera = input[ind]

      if x > 0:
        if map[y][x - 1] == camera.edges.up:
          input[ind].img = turnImage(camera.img, false)
          input[ind].edges = turnEdges(camera.edges, false)
          camera = input[ind]

        elif map[y][x - 1] == camera.edges.down:
          input[ind].img = turnImage(camera.img, true)
          input[ind].edges = turnEdges(camera.edges, true)
          camera = input[ind]

        elif map[y][x - 1] == camera.edges.right:
          input[ind].img = flipImage(camera.img, false)
          input[ind].edges = flipEdges(camera.edges, false)
          camera = input[ind]

      if x == 0 and camera.edges.left > 0:
        input[ind].img = flipImage(camera.img, false)
        input[ind].edges = flipEdges(camera.edges, false)
        camera = input[ind]

      if y == 0 and camera.edges.up > 0:
        input[ind].img = flipImage(camera.img, true)
        input[ind].edges = flipEdges(camera.edges, true)
        camera = input[ind]

      if camera.edges.down > 0 and y < len(map) - 1:
        map[y + 1][x] = camera.edges.down
      if camera.edges.right > 0 and x < len(row) - 1:
        map[y][x + 1] = camera.edges.right

# Remove edges from pieces
for ind, camera in input:
  input[ind].img = removeEdges(camera.img)

# Combine pieces to a single image
var image:seq[string]
for y, row in map:
  # The pieces are 8 x 8 with edges removed
  var imageRow: array[8, string]
  for x, ind in row:
    for imageY, val in input[ind].img:
      imageRow[imageY].add(val)
  image.add(imageRow)

# Make possible rotations of image
var possibilities = [
  flipImage(turnImage(image, true), false),
  flipImage(turnImage(image, true), true),
  flipImage(image, true),
  turnImage(image, true)
]

# Test untill correct orientation is found
for image in possibilities:
  let count = findMonsters(image)
  if count > 0:
    let monsterTiles = 15 * count
    let tiles = count(image.join, '#')

    echo "Part 1:"
    echo "  Corner multi: ", multi
    echo ""
    echo "Part 2:"
    echo "  Monsters: ", count
    echo "  Monster tiles: ", monsterTiles
    echo "  Total tiles: ", tiles
    echo "  Rough waters: ", tiles - monsterTiles
    break
