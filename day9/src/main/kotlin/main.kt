// ::eXchange-Masking Addition System (XMAS) DECODER::

import java.io.*

fun main(args: Array<String>) {
    val input = parseInput("input")
    val invalidNumber = decodeXMAS(input, 25, 0)
    println(invalidNumber)
    println(countContiguous(input, invalidNumber))
}

fun decodeXMAS(inputCodes: ArrayList<Long>, preamble: Int, counter: Int): Long {
    val index = counter + preamble

    if (index >= inputCodes.size) return inputCodes[index]

    val code = inputCodes[index]
    val codeList = inputCodes.subList(counter, index)

    for (num in codeList) {
        if (code - num != num && codeList.contains(code - num)) {
            return decodeXMAS(inputCodes, preamble, counter + 1)
        }
    }

    return code
}

fun countContiguous(inputCodes: ArrayList<Long>, numToMatch: Long): Long {
    for (i in 0 until inputCodes.size) {
        var sum = inputCodes[i]

        for (j in (i + 1) until inputCodes.size) {
            sum += inputCodes[j]

            if (sum > numToMatch) {
                break
            } else if (sum == numToMatch) {
                val subInput = inputCodes.subList(i, (j + 1))
                return (subInput.minOrNull() ?: 0) + (subInput.maxOrNull() ?: 0)
            }
        }
    }
    return 0L
}

fun parseInput(fileName: String): ArrayList<Long> {
    val file = object {}.javaClass.getResourceAsStream(fileName)
    val reader = file.bufferedReader()
    val numbers: ArrayList<Long> = ArrayList()

    for (line in reader.lines()) {
        numbers.add(line.toLong())
    }

    return numbers
}