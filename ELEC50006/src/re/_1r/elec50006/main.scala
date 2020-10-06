package re._1r.elec50006

object Main extends App {
  assert(args.length > 0, "no week number entered")
  println(args(0) match {
    case "1" => Week1.run(args.tail)
    case "2" =>
    case "3" =>
  })
}