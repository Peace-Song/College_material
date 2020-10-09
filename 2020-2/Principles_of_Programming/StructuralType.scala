import scala.annotation.tailrec

object HelloWorld {
  def main(args:Array[String]): Unit = {
    def bar(x: Int) = x + 1

    val foo = new {
      val a = 1 + 2
      def b = a + 1
      def f(x: Int) = b + x
      def f(x: String) = "hello" + x
      val g: Int => Int = bar _
    }
    
    type Foo = {val a: Int; def b: Int; def f(x: Int): Int; def f(x: String): String; val g: Int => Int}

    println(foo.a)
    println(foo.b)
    println(foo.f(3))

  }
}
