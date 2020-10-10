defmodule Week2 do
  def run(args) do
    case Enum.at(args, 0, "") do
      "--naïve" -> plt_ineff(Enum.at(tl(args), 0) |> Integer.parse() |> elem(0)) |> Enum.join(",") |> IO.puts()
      "--sqrt" -> plt_sqrt(Enum.at(tl(args), 0) |> Integer.parse() |> elem(0)) |> Enum.join(",") |> IO.puts()
      "--sieve" -> plt_sieve(Enum.at(tl(args), 0) |> Integer.parse() |> elem(0)) |> Enum.join(",") |> IO.puts()
      "--sieve2" -> plt_sieve2(Enum.at(tl(args), 0) |> Integer.parse() |> elem(0)) |> Enum.join(",") |> IO.puts()
      "--compare" -> (2..(Enum.at(tl(args), 0) |> Integer.parse() |> elem(0))) |> Enum.map(fn x ->
        "#{x}, #{[
          ELEC50006.time(x, &(plt_ineff(&1))),
          ELEC50006.time(x, &(plt_sqrt(&1))),
          ELEC50006.time(x, &(plt_sieve(&1))),
          ELEC50006.time(x, &(plt_sieve2(&1)))
        ] |> Enum.join(", ")}"
      end) |> Enum.join("\n") |> IO.puts()
    end
    0
  end
  def plt_ineff(n), do: [2 | Enum.reject(2..n - 1, fn n -> if n == 1, do: false, else: Enum.any?(2..n - 1, &(rem(n, &1) == 0)) end)]
  def plt_sqrt(n), do: [2 | Enum.reject(2..n -  1, fn n -> if n == 1, do: false, else: Enum.any?(2..trunc(:math.sqrt(n) + 1), &(rem(n, &1) == 0)) end)]
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
  def plt_sieve2(n) do
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
    [2 | Enum.reject(2..trunc(n / 2), fn x -> Enum.member?(notPrimes, x * 2 - 1) end) |> Enum.map(&(&1 * 2 - 1))]
  end
end
