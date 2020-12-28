open System.IO

let move dir =
  match dir with
  | 'd' -> (0, 1, -1)
  | 'f' -> (1, 0, -1)
  | 'g' -> (-1, 0, 1)
  | 'h' -> (0, -1, 1)
  | 'w' -> (-1, 1, 0)
  | 'e' -> (1, -1, 0)
  | a -> (0, 0, 0)

let rec checkAdjacent (tile, tileSet:Set<int * int * int>, recurse) =
  let mutable count = 0
  let mutable tmp = List.empty
  let mutable sub = Set.empty:Set<int * int * int>

  let (x, y, z) = tile
  let coords = [
    (x,     y + 1, z - 1);
    (x,     y - 1, z + 1);
    (x + 1, y,     z - 1);
    (x - 1, y,     z + 1);
    (x - 1, y + 1, z);
    (x + 1, y - 1, z)
  ]

  for coord in coords do
    if tileSet.Contains(coord) then
      count <- count + 1
    else
      tmp <- List.append tmp [coord]

  if recurse then
    for coord in tmp do
      if not(tileSet.Contains(coord)) then
        let (adj, _) = checkAdjacent(coord, tileSet, false)

        if adj.Equals(2) then
          sub <- sub.Add(coord)

  (count, sub)

let file =
  File.ReadAllText("resources/input")
  |> fun y -> y.Replace("nw", "d")
  |> fun y -> y.Replace("ne", "f")
  |> fun y -> y.Replace("sw", "g")
  |> fun y -> y.Replace("se", "h")
  |> fun y -> y.Split('\n')

let sumTuples((x1, y1, z1), (x2, y2, z2)) = (x1 + x2, y1 + y2, z1 + z2)

let mutable tiles = Set.empty:Set<int * int * int>

for q in 0 .. 100 do
  let mutable tmp = tiles

  if q.Equals(0) then
    for row in file do
      let mutable coord = (0,0,0)

      for char in row do
        coord <- sumTuples(coord, move char)

      if tmp.Contains(coord) then
        tmp <- tmp.Remove(coord)
      else
        tmp <- tmp.Add(coord)

    printfn "Part 1: %d" tmp.Count

  else
    for coord in tmp do
      let (adj, sub) = checkAdjacent(coord, tiles, true)
      for y in sub do
        tmp <- tmp.Add(y)

      if adj.Equals(0) || adj > 2 then
        tmp <- tmp.Remove(coord)

  tiles <- tmp

printfn "Part 2: %d" tiles.Count
