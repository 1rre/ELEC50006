defmodule ELEC50006 do
  def time(a, ty) do
    begin = System.monotonic_time(:nanosecond)
    ty.(a)
    fin = System.monotonic_time(:nanosecond)
    (fin - begin) / 1000000000
  end
end
