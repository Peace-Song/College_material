import scala.annotation.tailrec

object HelloWorld {
  def main(args:Array[String]): Unit = {
    println("sum((x) => x*x, 0, 10) == " + sum((x) => x*x, 0, 10))
    println("product(x) => x, 1, 10) == " + product((x) => x, 1, 10))
  }

  def mapReduce(reduce: (Int, Int) => Int, initVal: Int, map: Int => Int, a: Int, b: Int): Int = {
    if (a <= b) reduce(map(a), mapReduce(reduce, initVal, map, a + 1, b))
    else initVal
  }
  def sum(f: Int => Int, a: Int, b: Int): Int = mapReduce((x, y) => x + y, 0, f, a, b)
  def product(f: Int => Int, a: Int, b: Int): Int = mapReduce((x, y) => x * y, 1, f, a, b)
}
