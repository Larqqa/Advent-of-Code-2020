module Lib
    ( day8
    ) where

import System.Environment ( getArgs )

day8 :: IO ()
day8 = do
    args <- getArgs
    str <- readFile (head args)
    let ins = strToInstruction str
    print $ part1 ins [] 0 0
    print $ doPart2 ins 0

part1 :: [(String, Int)] -> [Int] -> Int -> Int -> Int
part1 instruct history position accumulator
    | position `elem` history = accumulator
    | otherwise = do
        let newHist = history ++ [position]
            (op, arg) = instruct !! position
        case (op, arg) of
            ("jmp", _) -> part1 instruct newHist (position + arg) accumulator
            ("acc", _) -> part1 instruct newHist (position + 1)  (accumulator + arg)
            ("nop", _) -> part1 instruct newHist (position + 1)   accumulator

part2 ::  [(String, Int)] -> [Int] -> Int -> Int -> Int
part2 instruct history position accumulator
    | position >= length instruct = accumulator
    | position `elem` history = 0
    | otherwise = do
        let newHist = history ++ [position]
            (op, arg) = instruct !! position
        case (op, arg) of
            ("jmp", _) -> part2 instruct newHist (position + arg) accumulator
            ("acc", _) -> part2 instruct newHist (position + 1)  (accumulator + arg)
            ("nop", _) -> part2 instruct newHist (position + 1)   accumulator

strToInstruction :: String -> [(String, Int)]
strToInstruction = map((\[op, arg] -> (op, parseInt arg)) . words) . lines

parseInt :: String -> Int
parseInt num
    | take 1 num == "+" = read . tail $ num
    | otherwise = (-1) * (read . tail $ num)

replaceAtIndex :: Int -> a -> [a] -> [a]
replaceAtIndex index elem list = take index list ++ [elem] ++ drop (index + 1) list

replaceOperation :: [(String, Int)] -> Int -> [(String, Int)]
replaceOperation instruct index =
    let (op, arg) = instruct !! index
    in case (op, arg) of
        ("jmp", _) -> replaceAtIndex index ("nop", arg) instruct
        ("nop", _) -> replaceAtIndex index ("jmp", arg) instruct
        ("acc", _) -> instruct

doPart2 :: [(String, Int)] -> Int -> Int
doPart2 instruct index = do
    let newInstruction = replaceOperation instruct index
        p2 = part2 newInstruction [] 0 0
    if p2 /= 0 then
        p2
    else
        doPart2 instruct (index + 1)