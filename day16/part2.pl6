my $fh = slurp "resources/input";
my @r = $fh.split("\n\n") :skip-empty;

my %rules = @r[0]
  .split("\n", :skip-empty)
  .map(-> $row {
    my @tmp = $row.split(": ");
    @tmp[1] = @tmp[1]
      .split(" or ")
      .map(-> $s {
        $s.split("-");
      });

    %(@tmp[0] => (@tmp[1], 0));
  });

my @ticket = @r[1].split("\n")[1]
  .split(",");

my @nearby = @r[2].split(":")[1]
  .split("\n") :skip-empty
  .map(-> $row { $row.split("\n") })
  .map(-> $row { $row.split(",") });

my @accepted;
my %sorted;
my $checked = 0;
my $valid = 0;
for @nearby -> @single {
  $checked = 1;

  for @single -> $t {
    $valid = 0;

    for %rules.kv -> $k, @v {
      if ($t >= @v[0][0][0] and $t <= @v[0][0][1])
      or ($t >= @v[0][1][0] and $t <= @v[0][1][1]) {
        $valid = 1;
        last;
      }
    }

    if $valid == 0 {
      $checked = 0;
      last;
    }
  }

  if $checked == 1 {
    @accepted.push(@single);
    for @single.kv -> $i, $s {

      if %sorted{$i} {
        %sorted{$i}.push($s)
      } else {
        %sorted{$i} = [$s]
      }
    };
  }
}

my %decoded;
while %rules {
  for %sorted.kv -> $i, @l {
    my $sum = 0;
    my $name;
    my $index;

    for %rules.kv -> $k, @v {
      $checked = 1;

      for @l -> $t {
        $valid = 0;

        if ($t >= @v[0][0][0] and $t <= @v[0][0][1])
        or ($t >= @v[0][1][0] and $t <= @v[0][1][1]) {
          $valid = 1;
        }

        if $valid == 0 { $checked = 0 }
      }

      if $checked == 1 {
        $sum += $checked;
        $name = $k;
        $index = $i;
      }
    }

    if $sum == 1 {
      %decoded{$name} = $index;
      %rules{$name}:delete;
    }
  }
}

my %ticket;
my $sum = 1;
for %decoded.kv -> $k, $v {
  %ticket{$k} = @ticket[$v];

  if $k.contains('departure') {
    $sum = $sum * @ticket[$v];
  }
}

say $sum;