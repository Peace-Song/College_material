import scala.annotation.tailrec

object HelloWorld {
  def main(args:Array[String]): Unit = {
    def foo(x: Int, y: Int, z: Int)(a: Int, b: Int): Int = x + y + z + a + b

    val f1 = (x: Int, z: Int, b: Int) => foo(x, 1, z)(2, b)
    val f2 = foo(_: Int, 1, _: Int)(2, _: Int)
    val f3 = (x: Int, z: Int) => ((b: Int) => foo(x, 1, z)(2, b))

    println("f1(1, 2, 3) == " + f1(1, 2, 3))
    println("f2(1, 2, 3) == " + f2(1, 2, 3))
    println("f3(1, 2)(3) == " + f3(1, 2)(3))

  }
}
