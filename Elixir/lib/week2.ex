defmodule Week2 do
  def run(args) do
    ELEC50006.time(5, fn y -> plt_ineff(y) end)
    ELEC50006.time(5, fn y -> plt_ineff(y) end)
    ELEC50006.time(5, fn y -> plt_ineff(y) end)
    case Enum.at(args, 0, "") do
      "--uniq" -> Week2.Uniq.run(tl(args))
      "--naïve" -> plt_ineff(Enum.at(tl(args), 0) |> Integer.parse() |> elem(0)) |> Enum.join(",") |> IO.puts()
      "--sqrt" -> plt_sqrt(Enum.at(tl(args), 0) |> Integer.parse() |> elem(0)) |> Enum.join(",") |> IO.puts()
      "--sieve" -> plt_sieve(Enum.at(tl(args), 0) |> Integer.parse() |> elem(0)) |> Enum.join(",") |> IO.puts()
      "--compare" ->
        if Enum.count(args) > 1 do
        range = (2..(Integer.parse(Enum.at(args, 1)) |> elem(0)))
          Plot.draw(
            {"Time for each method", "Number to calculate to ", "Time"},
            [
              {"Inefficient", Enum.map(range, &{&1, ELEC50006.time(&1, fn y -> plt_ineff(y) end)})},
              {"Square Root", Enum.map(range, &{&1, ELEC50006.time(&1, fn y -> plt_sqrt(y) end)})},
              {"Sieve", Enum.map(range, &{&1, ELEC50006.time(&1, fn y -> plt_sieve(y) end)})}
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

  #O(n²), #Ω(n)
  def plt_ineff(n), do: [2 | Enum.reject(2..n - 1, fn n -> if n == 1, do: false, else: Enum.any?(2..n - 1, &(rem(n, &1) == 0)) end)]

  #O(n^(3/2)) #Ω(n)
  def plt_sqrt(n), do: [2 | Enum.reject(2..n -  1, fn n -> if n == 1, do: false, else: Enum.any?(2..trunc(:math.sqrt(n) + 1), &(rem(n, &1) == 0)) end)]

  #O(n·log(n)) #Ω(n·log(n))
  #Actually runs in O(n²·log(n)) or O(n·log(n)²) due to extensive list creation... I'm not sure of big O of it?
  def plt_sieve(n) do
    k = trunc((n - 2) / 2)
    notPrimes = Enum.reduce(1..k, [1], fn i, primes ->
      Enum.reduce(i..k, primes, fn j, primes ->
        if i + j + 2 * i * j <= k do
          [2 * (i + j + 2 * i * j) + 1 | primes]
        else
          primes
        end
      end)
    end)
    Enum.reject(1..n, fn x -> rem(x, 2) == 0 && x != 2 || Enum.member?(notPrimes, x) end)
  end
end
