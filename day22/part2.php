<?php
ini_set('display_errors', '1');

/**
 * Day 22 of AoC
 * Part2
 */

[$player1, $player2] = array_map(
  function ($x) {
    $tmp = explode(":\n", $x);
    return ['user' => $tmp[0], 'cards' => explode("\n", $tmp[1])];
  },
  explode("\n\n", file_get_contents('resources/input'))
);

function checkIfArrayInArray($find, $in) {
  $count = 0;

  foreach ($in as $arr) {
    if ($find === $arr) {
      $count++;
    }
  }

  return $count > 0 ? true : false;
}

function recursiveCombat($p1, $p2) {
  $p1Rounds = [];
  $p2Rounds = [];

  while (sizeof($p1) > 0 && sizeof($p2) > 0) {

    // If hand is exact with a hand from earlier rounds p1 wins
    if (checkIfArrayInArray($p1, $p1Rounds) || checkIfArrayInArray($p2, $p2Rounds)) {
      return [$p1, 0];
    }

    // Add hand to round stack
    array_push($p1Rounds, $p1);
    array_push($p2Rounds, $p2);

    // Play cards
    $c1 = array_shift($p1);
    $c2 = array_shift($p2);

    // If both decks have more cards than the value of the played cards, play a sub game
    if (sizeof($p1) >= $c1 && sizeof($p2) >= $c2) {
      [$subP1, $subP2] = recursiveCombat(array_slice($p1, 0, $c1), array_slice($p2, 0, $c2));

      if (sizeof($subP1) != 0) {
        $p1 = array_merge($p1, [$c1, $c2]);
      } else {
        $p2 = array_merge($p2, [$c2, $c1]);
      }
    } elseif ($c1 > $c2) {
      $p1 = array_merge($p1, [$c1, $c2]);
    } else {
      $p2 = array_merge($p2, [$c2, $c1]);
    }
  }

  return [$p1, $p2];
}

[$p1, $p2] = recursiveCombat($player1['cards'], $player2['cards']);
echo 'Part2: ';
echo sizeof($p1) != 0
 ? 'player 1: ' . calculateScore($p1)
 : 'player 2: ' . calculateScore($p2);
