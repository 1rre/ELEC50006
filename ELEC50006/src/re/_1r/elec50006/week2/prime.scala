package re._1r.elec50006

object Week2 {
	def time(x: Int => Any, y: Int) = {
		val begin = java.lang.System.nanoTime
		(1 to 5).foreach(_=> x(y))
		(java.lang.System.nanoTime - begin) / (5 * 1000000000d)
	}
	def run(args: Array[String]) = {
		assert(args.length > 0, "expected >2 args")
		args.head match {
			case "--naive" => pltIneff(args(1).toIntOption.getOrElse(sys.error(s"Non int found: ${args(1)}"))).mkString(",")
			case "--sqrt" => pltSqrt(args(1).toIntOption.getOrElse(sys.error(s"Non int found: ${args(1)}"))).mkString(",")
			case "--sieve" => pltSieve(args(1).toIntOption.getOrElse(sys.error(s"Non int found: ${args(1)}"))).mkString(",")
			case "--compare" => {
				val out = Array.tabulate(500)(i => {
					time(pltSieve(_:Int), math.pow(2, i/20d).toInt)
				})
				println(out.mkString("\n"))
				while(true) {}
			}
			case "--test" => println(time(pltSieve(_: Int), 1000000))
		}
	}
	def pltIneff(n: Int) = 2 +: (2 until n).filterNot(n => n == 1 || (2 until n).exists(n % _ == 0))
	def pltSqrt(n: Int) = 2 +: (2 until n).filterNot(n => n == 1 || (2 to math.sqrt(n).toInt + 1).exists(n % _ == 0))
	def pltSieve(n: Int) = {
		def k = ((n - 2) / 2)
		val primes = Array.tabulate(k)(x => x + 1)
		for(i <- 1 to k; j <- i to (k - i) / (1 + 2 * i)){
			primes(i + j + 2 * i * j - 1) = 0
		}
		2 +: primes.filterNot(_ == 0).map(_ * 2 + 1)
	}
}