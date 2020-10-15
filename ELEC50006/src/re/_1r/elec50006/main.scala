package re._1r.elec50006

object Main extends App {
  Test
  assert(args.length > 0, "no week number entered")
  println(args(0) match {
    case "1" => Week1.run(args.tail)
    case "2" => Week2.run(args.tail)
    case "3" =>
  })
}

object Test {
  (1 to Int.MaxValue).foreach(i =>
    assert(Week1.fibFor(i) == Week1.fibStr(i), s"${i}")
  )
}