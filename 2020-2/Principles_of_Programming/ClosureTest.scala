import scala.annotation.tailrec

object HelloWorld {
  def main(args:Array[String]): Unit = {
    val t = 0
    val f: Int=>Int = {
      val t = 10
      def g(x: Int): Int = x + t
      g 
    }

    println(f(20))

  }
}
