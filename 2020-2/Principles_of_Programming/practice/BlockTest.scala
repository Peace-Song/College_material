object HelloWorld {
  def main(args:Array[String]): Unit = {
    def func(c: Boolean, i: =>Int): Int = {
      lazy val iv = i
      if (c) 0
      else iv * iv * iv
    }

    func(true, {
      println("true")
      100 + 100 + 100
    })
    func(false, {
      println("false")
      100 + 100 + 100
    })
  }
}
