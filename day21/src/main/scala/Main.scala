import scala.io.Source
import scala.collection.mutable.{Map => MMap}

class Food (var str: String) {
  var Array(ingredients, allergens) = str
    .replace(")", "")
    .replace(",", "")
    .split(" \\(contains ")
    .map(x => x.split(" ").toSet)
  def info: List[(String, Set[String])] = (allergens map (a => a -> ingredients)).toList
}

object Main {
  def main (args: Array[String]): Unit = {
    val foods = Source.fromInputStream(
      getClass.getResourceAsStream("input")
    ).getLines.toArray.map(line => new Food(line))

    val allergens = findAllergens(foods)
    println(s"Part 2: ${listAllergens(allergens)}")
  }

  def findAllergens (foods: Array[Food]): Map[String, Set[String]] = {
    val possibleAllergens = foods.flatMap(_.info)
      .groupBy(_._1)
      .mapValues(_.map(_._2)
        .reduce(_ intersect _))

    val nonAllergens = foods.flatMap(_.ingredients)
      .filterNot(possibleAllergens.values.reduce(_ union _)).length

    println(s"Part 1: ${nonAllergens}")

    possibleAllergens
  }

  def listAllergens (foods: Map[String, Set[String]]): String = {
    val dangerous = MMap[String, String]()
    var theFoods = foods

    // Assume we have a Set with only one allergen each iteration
    while (theFoods.size > 0) {
      for ((ingredient, allergens) <- theFoods) {
        if (allergens.size == 1) {
          val allergen = allergens.toSeq(0)
          dangerous(ingredient) = allergen
          theFoods = theFoods.-(ingredient)
          theFoods = theFoods.mapValues(i => i.filter { a => a != allergen })
        }
      }
    }

    val listOfDangerous = dangerous.toSeq
      .sortBy(_._1)
      .toList
      .map { case (x, y) => y }
      .mkString(",")

    listOfDangerous
  }
}
