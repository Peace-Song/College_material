import scala.annotation.tailrec

object HelloWorld {
  def main(args:Array[String]): Unit = {
    def f(x: Int) = g(x)
    val a = 10
    def g(x: Int) = 10
    f(10)
  }
}
