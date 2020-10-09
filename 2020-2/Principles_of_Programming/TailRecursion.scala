import scala.annotation.tailrec

object HelloWorld {
  def main(args:Array[String]): Unit = {
    println("sum(100) == " + sum(100))
  }

  def sum(n: Int): Int = {
    @tailrec
    def sumTail(i: Int, acc: Int): Int = {
      if (i == 0) acc
      else sumTail(i - 1, acc + i)
    }

    sumTail(n, 0)
  }
}
