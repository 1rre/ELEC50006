Enum.each(1..999999, fn x ->
  if Week1.fib_formula(x) != Week1.fib_store(x) do
    IO.puts(x)
    System.halt()
  end
end)
