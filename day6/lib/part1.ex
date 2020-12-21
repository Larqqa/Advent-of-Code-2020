defmodule Part1 do
  IO.puts File.read!("input")
    |> String.split("\n\n")
    |> Enum.to_list
    |> Enum.map(fn el ->
      String.replace(el, "\n", "")
    end)
    |> Enum.map(fn el ->
      String.graphemes(el)
      |> Enum.reduce(%{}, fn char, acc ->
          Map.update(acc, char, 1, &(&1 * 1))
        end)
    end)
    |> Enum.reduce(fn x, acc ->
      Map.merge(x, acc, fn _k, v1, v2 ->
        v1 + v2
      end)
    end)
    |> Enum.reduce(0, fn({_, b}, acc) ->
      acc + b
    end)
end

Part1.part1(File.read!("training"))
