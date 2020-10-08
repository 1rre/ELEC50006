defmodule Week1 do
  def run(args) do
    case Enum.at(args, 0, "") do
      "--recursive" ->
        Enum.each(tl(args), fn n ->
          Integer.parse(n) |> elem(0) |> fib_recursive() |> IO.puts()
        end)
      "--array" ->
        Enum.each(tl(args), fn n ->
          Integer.parse(n) |> elem(0) |> fib_array() |> IO.puts()
        end)
      "--store" ->
        Enum.each(tl(args), fn n ->
          Integer.parse(n) |> elem(0) |> fib_store() |> IO.puts()
        end)
      "--formula" ->
        Enum.each(tl(args), fn n ->
          Integer.parse(n) |> elem(0) |> fib_formula() |> IO.puts()
        end)
      "--matrix" ->
        Enum.each(tl(args), fn n ->
          Integer.parse(n) |> elem(0) |> fib_matrix() |> IO.puts()
        end)
      "--compare" ->
        if Enum.count(args) > 1 do
          range = (0..(Integer.parse(Enum.at(args, 1)) |> elem(0)))
          Plot.draw(
            {"Time for each method", "Number to calculate to ", "Time"},
            [
              {"Recursive", Enum.map(range, fn x ->
                begin = System.monotonic_time(:nanosecond)
                fib_recursive(x)
                fin = System.monotonic_time(:nanosecond)
                {x, begin - fin}
              end)},
              {"Array", Enum.map(range, fn x ->
                begin = System.monotonic_time(:nanosecond)
                fib_array(x)
                fin = System.monotonic_time(:nanosecond)
                {x, begin - fin}
              end)},
              {"Store Last 2", Enum.map(range, fn x ->
                begin = System.monotonic_time(:nanosecond)
                fib_store(x)
                fin = System.monotonic_time(:nanosecond)
                {x, begin - fin}
              end)},
              {"Matrix", Enum.map(range, fn x ->
                begin = System.monotonic_time(:nanosecond)
                fib_matrix(x)
                fin = System.monotonic_time(:nanosecond)
                {x, begin - fin}
              end)}
            ]
          )
        else
          exit("No number to plot")
        end
      _ ->
        exit("No option selected")
    end
  end

  def time(a, ty) do
    begin = System.monotonic_time(:nanosecond)
    _ = ty.(a)
    fin = System.monotonic_time(:nanosecond)
    fin - begin
  end

  def fib_recursive(n) do
    if n < 3 do
      1
    else
      fib_recursive(n - 1) + fib_recursive(n - 2)
    end
  end

  def fib_array(n, i\\2, arr\\[1, 1]) do
    if i < n do
      fib_array(n, i + 1, [Enum.at(arr, 0) + Enum.at(arr, 1) | arr])
    else
      hd(arr)
    end
  end

  def fib_store(n, i\\2, last\\{1, 1}) do
    if i < n do
      fib_store(n, i + 1, {elem(last, 0) + elem(last, 1), elem(last, 0)})
    else
      elem(last, 0)
    end
  end

  def pow(a, n) do
    case n do
      0 -> 1
      1 -> n
      _ -> pow(a * a, div(n, 2)) * (if rem(n, 2) == 0 do 1 else a end)
    end
  end

  def fib_formula(n) do
    phi = (1 + :math.sqrt(5)) / 2
    trunc((pow(phi, n) - pow(1 - phi, n)) / :math.sqrt(5))
  end

  def m_mul(a, b) do
    {
      {
        elem(elem(a,0),0) * elem(elem(b,0),0) + elem(elem(a,0),1) * elem(elem(b,1),0),
        elem(elem(a,0),0) * elem(elem(b,0),1) + elem(elem(a,0),1) * elem(elem(b,1),1)
      },
      {
        elem(elem(a,1),0) * elem(elem(b,0),0) + elem(elem(a,1),1) * elem(elem(b,1),0),
        elem(elem(a,1),0) * elem(elem(b,0),1) + elem(elem(a,1),1) * elem(elem(b,1),1)
      }
    }
  end

  def m_pow(a, n) do
    case n do
      0 -> {{1,0},{0,1}}
      1 -> a
      _ -> m_mul(a, a) |> m_pow(div(n, 2)) |> m_mul(if rem(n, 2) == 0 do {{1,0},{0,1}} else a end)
    end
  end

  def fib_matrix(n) do
    m_pow({{1,1},{1,0}}, n - 1) |> elem(0) |> elem(0)
  end
end
