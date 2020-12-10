#include <iostream>
#include <fstream>
#include <set>
#include <algorithm>
#include <vector>
#include <iterator>

std::set<int> getInput(std::string fileName) {
    std::ifstream inFile(fileName);

    if (!inFile) {
        std::cout << "Could not open input file\n";
        EXIT_FAILURE;
    }

    std::set<int> numbers;
    numbers.insert(0); // init with a 0

    int num;
    while(inFile >> num) {
        numbers.insert(num);
    }

    return numbers;
}

int countJolts(std::set<int> numbers) {
    int ones = 0;
    int threes = 1; // Last jump of three is always present

    std::set<int>::iterator it = numbers.begin();
    std::set<int>::iterator it2 = numbers.begin();
    it2++;

    while (it2 != numbers.end()) {
        if (*it2 - *it == 1) ones++;
        if (*it2 - *it == 3) threes++;

        it++;
        it2++;
    }

    return ones * threes;
}

int countPossiblePaths(std::set<int> numbers) {
    int counter = 0;
    int count;

    std::set<int>::iterator it = numbers.begin();
    std::set<int>::iterator it2;

    while (it != numbers.end()) {
        it2 = numbers.begin();
        it2++;

        count = 0;
        while (it2 != numbers.end()) {
            if (*it2 - *it <= 3 && *it2 - *it > 0) {
                count++;
            }

            it2++;
        }

        if (count != 1) counter += count;

        it++;
    }

    if (numbers.size() > 3) counter--;

    return counter;
}

std::vector<std::set<int>> countCombinations(std::set<int> numbers) {
    bool one;
    bool two;
    bool three;

    int startRange = -1;
    int index = 0;
    int rangeLength;

    std::vector<std::set<int>> setList;
    std::set<int> subSet;
    std::set<int>::iterator it = numbers.begin();
    std::set<int>::iterator it2;

    while (it != numbers.end()) {

        // Check if current number has jumps
        one   = numbers.count(*it + 1) == 1;
        two   = numbers.count(*it + 2) == 1;
        three = numbers.count(*it + 3) == 1;

        // Check if current number has two or more jumps it's the first number of the range
        if (startRange == -1 && ((one && two) || (one && three) || (two && three))) {
            startRange = index;
        }

        // If range counting was started and no jumps were found
        if (startRange != -1 && (! (one && two) && ! (one && three) && ! (two && three))) {
            rangeLength = (index + 1) - startRange;
            it2 = numbers.begin();
            advance(it2, startRange);

            for (int i = 0; i <= rangeLength; i++) {
                subSet.insert(*it2);
                it2++;
            }

            startRange = -1;
            setList.push_back(subSet);
            subSet = {};
        }

        index++;
        it++;
    }

    return setList;
}

int main() {
    std::set<int> numbers;
    numbers = getInput("input");

    // Part1
    std::cout << countJolts(numbers) << std::endl;

    // Part 2
    long total = 1;
    std::vector<std::set<int>> subSetList = countCombinations(numbers);
    for(std::set<int> subSet: subSetList) {
        total *= countPossiblePaths(subSet);
    }

    std::cout << total << std::endl;

    return 0;
}