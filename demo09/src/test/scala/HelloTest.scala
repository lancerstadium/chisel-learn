import chiseltest._
import chisel3._
import chisel3.util._
import org.scalatest.flatspec.AnyFlatSpec

class Seg7Test extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Seg7"
  it should "pass" in {
    test(new Seg7) { c =>
        c.clock.setTimeout(0)
        // c.io.sw := 0.U
        println("Start the blinking LED")
        for (_ <- 0 until 100) {
            c.clock.step(10000)
            // c.io.sw := c.io.sw + 1.U
            // val ledNow = c.io.segOut.peek().litValue
            // println(ledNow)
        }
        println("\nEnd the blinking LED")
    }
  }
}
