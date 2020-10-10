case Enum.at(System.argv, 0, "") do
  "1" -> Week1.run(tl(System.argv))
  "2" -> Week2.run(tl(System.argv))
   x  -> exit("expected a week number - got #{x}")
end
