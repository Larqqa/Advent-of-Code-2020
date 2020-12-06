defmodule Part2 do
  IO.puts File.read!("input")
    |> String.split("\n\n")
    |> Enum.to_list
    |> Enum.map(fn el ->
      str = String.split(el, "\n")

      Enum.map(str, fn el ->
        String.graphemes(el)
        |> Enum.reduce(%{}, fn char, acc ->
            Map.update(acc, char, 1, &(&1 + 1))
          end)
      end)
    end)
    |> Enum.map(fn el ->
      len = length(el)

      Enum.reduce(el, fn x, acc ->
        Map.merge(x, acc, fn _k, v1, v2 ->
          v1 + v2
        end)
      end)
      |> Enum.map(fn {k, v} ->
        if v == len do
          %{k => 1}
        else
          %{k => 0}
        end
      end)
      |> Enum.reduce(fn x, acc ->
        Map.merge(x, acc, fn _k, v1, v2 ->
          v1 * v2
        end)
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
