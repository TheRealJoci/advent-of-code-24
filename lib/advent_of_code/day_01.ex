defmodule AdventOfCode.Day01 do
  defp do_insert_in_order(list, value)
  defp do_insert_in_order([], value), do: [value]
  defp do_insert_in_order([hd | tl], value) when hd >= value, do: [value, hd | tl]
  defp do_insert_in_order([hd | tl], value), do: [hd | do_insert_in_order(tl, value)]

  def part1(_args) do
    input = AdventOfCode.Input.get!(1, 2024)

    input
    |> String.trim()
    |> String.split(~r/\s+/)
    |> Enum.with_index()
    |> Enum.reduce([[], []], fn {id, index}, [left, right] ->
      if rem(index, 2) === 0 do
        [do_insert_in_order(left, String.to_integer(id)), right]
      else
        [left, do_insert_in_order(right, String.to_integer(id))]
      end
    end)
    |> Enum.zip()
    |> Enum.map(fn {left, right} ->
      abs(left - right)
    end)
    |> Enum.sum()
  end

  def part2(_args) do
    input = AdventOfCode.Input.get!(1, 2024)

    {ids, counter} =
      input
      |> String.trim()
      |> String.split(~r/\s+/)
      |> Enum.with_index()
      |> Enum.reduce({[], Map.new()}, fn {id, index}, {ids, counter} ->
        if rem(index, 2) === 0 do
          {[String.to_integer(id) | ids], counter}
        else
          {ids, Map.update(counter, String.to_integer(id), 1, fn count -> count + 1 end)}
        end
      end)

    ids
    |> Enum.map(fn id -> id * Map.get(counter, id, 0) end)
    |> Enum.sum()
  end
end
