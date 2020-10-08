defmodule Plot do
  import Gnuplot
  def draw(titles, series) do
    plot([
      [:set, :title, "#{elem(titles, 0)}"],
      [:set, :xlabel, "#{elem(titles, 1)}"],
      [:set, :ylabel, "#{elem(titles, 2)}"],
      plots(Enum.map(series |> Enum.with_index(1), &["-", :title, "#{elem(&1, 0) |> elem(0)}", :with, :lines, :ls, elem(&1, 1)]))
    ], Enum.map(series, &elem(&1, 1)))

  end
end
