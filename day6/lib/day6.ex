defmodule Day6_part1 do
  file = File.read!("input")
    |> String.split("\n\n")
    |> Enum.to_list
    |> Enum.map(fn el ->
      String.replace(el, "\n", "")
    end)

  file2 =
    file
    |> Enum.map(fn el ->
      String.graphemes(el)
      |> Enum.reduce(%{}, fn char, acc ->
          Map.update(acc, char, 1, &(&1 * 1))
        end)
    end)

  combined_map =
    file2
    |> Enum.reduce(fn x, acc ->
        Map.merge(x, acc, fn _k, v1, v2 ->
          v1 + v2
        end)
      end)

  IO.puts Enum.reduce(combined_map, 0, fn({_, b}, acc) ->
    acc + b
  end)
end

defmodule Day6_part2 do

  file = File.read!("training")
    |> String.split("\n\n")
    |> Enum.to_list

  file2 =
    file
    |> Enum.map(fn el ->
      str = String.split(el, "\n")

      Enum.map(str, fn el ->
        String.graphemes(el)
        |> Enum.reduce(%{}, fn char, acc ->
            Map.update(acc, char, 1, &(&1 + 1))
          end)
      end)
    end)
  # IO.inspect file2

  IO.inspect Enum.map(file2, fn el ->
    len = length(el)
    IO.puts len

    elems = Enum.reduce(el, fn x, acc ->
      Map.merge(x, acc, fn _k, v1, v2 ->
        v1 + v2
      end)
    end)

    elems = Enum.reduce(%{}, fn char, acc ->
      char == len
    end)
    IO.inspect elems
  end)

  combined_map =
    file2
    |> Enum.reduce(fn x, acc ->
        Map.merge(x, acc, fn _k, v1, v2 ->
          v1 + v2
        end)
      end)

  # IO.inspect combined_map
  IO.puts Enum.reduce(combined_map, 0, fn({_, b}, acc) ->
    acc + b
  end)
end
