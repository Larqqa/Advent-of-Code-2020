// ::eXchange-Masking Addition System (XMAS) DECODER::

import java.io.*

fun main(args: Array<String>) {
    val input = parseInput("input")
    val invalidNumber = decodeXMAS(input, 25, 0)
    println(invalidNumber)
    println(countContiguous(input, invalidNumber, 0, 0))
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

fun countContiguous(inputCodes: ArrayList<Long>, numToMatch: Long, rangeStart: Int, rangeEnd: Int): Long {
    val subList = inputCodes.subList(rangeStart, rangeEnd)
    val sum = subList.sum()

    return when {
        sum > numToMatch -> {
            countContiguous(inputCodes, numToMatch, (rangeStart + 1), rangeEnd)
        }
        sum < numToMatch -> {
            countContiguous(inputCodes, numToMatch, rangeStart, (rangeEnd + 1))
        }
        sum == numToMatch -> {
            (subList.minOrNull() ?: 0) + (subList.maxOrNull() ?: 0)
        }
        else -> 0L
    }

}
