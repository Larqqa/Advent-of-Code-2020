# defmodule Part1 do
#   IO.puts File.read!("input")
#     |> String.split("\n\n")
#     |> Enum.to_list
#     |> Enum.map(fn el ->
#       String.replace(el, "\n", "")
#     end)
#     |> Enum.map(fn el ->
#       String.graphemes(el)
#       |> Enum.reduce(%{}, fn char, acc ->
#           Map.update(acc, char, 1, &(&1 * 1))
#         end)
#     end)
#     |> Enum.reduce(fn x, acc ->
#       Map.merge(x, acc, fn _k, v1, v2 ->
#         v1 + v2
#       end)
#     end)
#     |> Enum.reduce(0, fn({_, b}, acc) ->
#       acc + b
#     end)
# end

defmodule Part1V2 do
  def count(str) do
    str
      |> Map.new( &{<<&1 :: utf8>>, Enum.count(str, fn x -> &1 == x end)})
  end

  def part1(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.replace(&1, "\n", "") |> to_charlist |> count)
    |> Enum.map(fn x -> Enum.map(x, fn {k,v} -> IO.inspect k end)  end)
    |> IO.inspect
  end

  def part2(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.replace(&1, "\n", "") |> to_charlist |> count)
  end
end

Part1V2.part1(File.read!("training"))
