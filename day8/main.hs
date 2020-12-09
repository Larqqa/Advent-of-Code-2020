main :: IO ()
main = do
    str <- readFile "input"
    let yeet = part1 (strToInstruction str) [] 0 0
    let ins = strToInstruction str
    print $ doPart2 ins 0

strToInstruction :: String -> [(String, Int)]
strToInstruction = map((\[op, arg] -> (op, parseInt arg)) . words) . lines

parseInt :: String -> Int
parseInt num = do
    if  take 1 num == "+" then
        read . tail $ num
    else
        ((-1) * (read . tail $ num))

part1 ::  [(String, Int)] -> [Int] -> Int -> Int -> Int
part1 instruct history position accumulator =
    if elem position history then
        accumulator
    else do
        let newHist = history ++ [position]
            (op, arg) = instruct !! position
        if op == "jmp" then
            part1 instruct newHist (position + arg) accumulator
        else if op == "acc" then
            part1 instruct newHist (position + 1) (accumulator + arg)
        else
            part1 instruct newHist (position + 1) accumulator

part2 ::  [(String, Int)] -> [Int] -> Int -> Int -> Int
part2 instruct history position accumulator =
    if position >= length instruct then
        accumulator
    else if elem position history then
        0
    else do
        let newHist = history ++ [position]
            (op, arg) = instruct !! position
        if op == "jmp" then
            part2 instruct newHist (position + arg) accumulator
        else if op == "acc" then
            part2 instruct newHist (position + 1) (accumulator + arg)
        else
            part2 instruct newHist (position + 1) accumulator

replaceAtIndex :: Int -> a -> [a] -> [a]
replaceAtIndex i x xs = take i xs ++ [x] ++ drop (i+1) xs

replaceOperation :: [(String, Int)] -> Int -> [(String, Int)]
replaceOperation instruct index = do
    let (f, b) = instruct !! index
    if f == "jmp" then
        replaceAtIndex index ("nop", b) instruct
    else if f == "nop" then
        replaceAtIndex index ("jmp", b) instruct
    else
        instruct

doPart2 :: [(String, Int)] -> Int -> Int
doPart2 instruct i = do
    let newIns = replaceOperation instruct i
        p2 = part2 newIns [] 0 0
    if p2 /= 0 then
        p2
    else
        doPart2 instruct (i + 1)