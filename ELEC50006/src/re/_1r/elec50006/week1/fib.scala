package re._1r.elec50006

object Week1 {
  def run(args: Array[String]) = {
    assert(args.length > 0, "not enough arguments. Expected at least 1")
    args(0) match {
      case "--recursive" => args.tail.zip(args.tail.map(n => fibRec(n.toIntOption.getOrElse(sys.error(s"non int literal ${n} found"))))).mkString("\n") 
      case "--array"     => args.tail.zip(args.tail.map(n => fibArr(n.toIntOption.getOrElse(sys.error(s"non int literal ${n} found"))))).mkString("\n") 
      case "--store"     => args.tail.zip(args.tail.map(n => fibStr(n.toIntOption.getOrElse(sys.error(s"non int literal ${n} found"))))).mkString("\n") 
      case "--formula"   => args.tail.zip(args.tail.map(n => fibFor(n.toIntOption.getOrElse(sys.error(s"non int literal ${n} found"))))).mkString("\n") 
      case "--matrix"    => args.tail.zip(args.tail.map(n => fibMat(n.toIntOption.getOrElse(sys.error(s"non int literal ${n} found"))))).mkString("\n") 
      case "--compare"   => {
        import java.lang.System.currentTimeMillis
        assert(args.tail.length > 0, "number of runs not found")
        (0 to args(1).toIntOption.getOrElse(sys.error(s"non int literal ${args(1)} found"))).map(x => {
          Array(
            ("Recursion", {
              val start = currentTimeMillis
              fibRec(x)
              currentTimeMillis - start
            }),
            ("Array", {
              val start = currentTimeMillis
              fibArr(x)
              currentTimeMillis - start
            }),
            ("Store", {
              val start = currentTimeMillis
              fibStr(x)
              currentTimeMillis - start
            }),
            ("Formula", {
              val start = currentTimeMillis
              fibFor(x)
              currentTimeMillis - start
            }),
            ("Matrix", {
              val start = currentTimeMillis
              fibMat(x)
              currentTimeMillis - start
            })
          ).mkString(",")
        }).tail.mkString("\n")
      }
      case x => sys.error(s"Expected an argument. Got ${x}")
    } 
  }

  def fibRec(n: Int): Int = if (n < 3) 1 else fibRec(n - 1) + fibRec(n - 2)
  
  def fibArr(n: Int): Int = {
    val fibs = collection.mutable.Stack[Int](1, 1)
    (2 until n).foreach(_ => fibs.push(fibs(0) + fibs(1)))
    fibs.pop
  }

  def fibStr(n: Int, i: Int = 2, last: (Int, Int) = (1, 1)): Int = {
    if (i < n) fibStr(n, i + 1, (last._1 + last._2, last._1))
    else last._1
  }

  def fibFor(n: Int): Int = {
    val phi = (1 + math.sqrt(5)) / 2
    def pow(x: Double, n: Int): Double = if (n == 0) 1 else x * pow(x, n - 1)
    ((pow(phi, n) - pow(1 - phi, n)) / math.sqrt(5)).toInt
  } 

  def fibMat(n: Int) = {
    case class Mat2x2(v: ((Int, Int), (Int, Int))) {
      def identity = Mat2x2((1, 0),(0, 1))
      def *(n: Mat2x2): Mat2x2 = Mat2x2(
        (v._1._1 * n.v._1._1 + v._1._2 * n.v._2._1, v._1._1 * n.v._1._2 + v._1._2 * n.v._2._2),
        (v._2._1 * n.v._1._1 + v._2._2 * n.v._2._1, v._2._1 * n.v._1._2 + v._2._2 * n.v._2._2 )
      )
      def ^^(n: Int): Mat2x2 = {
        if (n == 0) identity
        else if (n == 1) this
        else ((this * this) ^^ (n / 2)) * (if (n % 2 == 0) identity else this) 
      }
    }

    (Mat2x2((1, 1), (1, 0)) ^^ n - 1).v._1._1
  }
}