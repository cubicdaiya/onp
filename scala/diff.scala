
import onp.Diff

object main {
  def main(args: Array[String]) = {
    val diff = new Diff[Char](args(0).toCharArray(), args(1).toCharArray())
    println("editdistance: " + diff.editdistance)
  }
}
