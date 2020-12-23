<?php
ini_set('display_errors', '1');

/**
 * Day 22 of AoC
 * Part1
 */

[$player1, $player2] = array_map(
  function ($x) {
    $tmp = explode(":\n", $x);
    return ['user' => $tmp[0], 'cards' => explode("\n", $tmp[1])];
  },
  explode("\n\n", file_get_contents('resources/input'))
);

while (sizeof($player1['cards']) > 0 && sizeof($player2['cards']) > 0) {
  $c1 = array_shift($player1['cards']);
  $c2 = array_shift($player2['cards']);

  if ($c1 > $c2) {
    $player1['cards'] = array_merge($player1['cards'], [$c1, $c2]);
  } else {
    $player2['cards'] = array_merge($player2['cards'], [$c2, $c1]);
  }
}

function calculateScore($cards) {
  $score = 0;
  foreach (array_reverse($cards) as $i => $card) {
    $score += $card * ($i + 1);
  }
  return $score;
}

echo 'Part1: ';
echo sizeof($player1['cards']) != 0
 ? 'player 1: ' . calculateScore($player1['cards'])
 : 'player 2: ' . calculateScore($player2['cards']);
