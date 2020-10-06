case Enum.at(System.argv, 0, "") do
  "" -> exit("No week selected")
  "1" -> Week1.run(tl(System.argv))
end
