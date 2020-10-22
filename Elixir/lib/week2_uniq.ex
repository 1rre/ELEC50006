defmodule Week2.Uniq do
  def run(args) do
    ELEC50006.time(5, fn y -> first(gen_list(y)) end)
    ELEC50006.time(5, fn y -> first(gen_list(y)) end)
    ELEC50006.time(5, fn y -> first(gen_list(y)) end)
    case Enum.at(args, 0, "") do
      "--first" -> first(gen_list(Enum.at(args, 1, "0") |> Integer.parse() |> elem(0))) |> Enum.join(",") |> IO.puts()
      "--sort" -> sort(Enum.at(args, 1, "0") |> Integer.parse() |> elem(0)) |> Enum.join(",") |> IO.puts()
      "--map" -> map(Enum.at(args, 1, "0") |> Integer.parse() |> elem(0)) |> Enum.join(",") |> IO.puts()
      "--compare" ->
        if Enum.count(args) > 1 do
        range = (2..(Integer.parse(Enum.at(args, 1)) |> elem(0)))
          Plot.draw(
            {"Time for each method", "Number to calculate to ", "Time"},
            [
              {"First", Enum.map(range, &{&1, ELEC50006.time(&1, fn y -> first(gen_list(y)) end)})},
              {"Sorting", Enum.map(range, &{&1, ELEC50006.time(&1, fn y -> sort(gen_list(y)) end)})},
              {"Hash", Enum.map(range, &{&1, ELEC50006.time(&1, fn y -> map(gen_list(y)) end)})}
            ]
          )
        else
          exit("No number to plot")
        end
      _ ->
        exit("No option selected")
    end
    0
  end

  def gen_list(n), do: Enum.map(1..n, &round(:rand.normal * &1))

  def first(list), do: Enum.reduce(list, [], &(if Enum.member?(&2, &1), do: &2, else: [&1 | &2]))

  def sort(list), do: Enum.sort(list) |> Enum.reduce([], &(if List.last(&2) == &1, do: &2, else: [&1 | &2]))

  def map(list), do: Enum.reduce(list, MapSet.new, &(MapSet.put(&2, &1)))


end
