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

    %(@tmp[0] => %(
      "low" => @tmp[1][0],
      "high" => @tmp[1][1]
    ));
  });

my @ticket = @r[1].split("\n")[1]
  .split(",");

my %sorted;
@r[2].split(":")[1]
  .split("\n") :skip-empty
  .map(-> $row { $row.split("\n") })
  .map(-> $row {
    my @tmp = $row.split(",");
    my $valid = 1;

    # Validate that all rules apply
    for @tmp -> $t {
      my $check = 0;

      for %rules.kv -> $k, %v {
        if ($t >= %v{"low"}[0] and $t <= %v{"low"}[1])
        or ($t >= %v{"high"}[0] and $t <= %v{"high"}[1]) {
          $check = 1;
        }
      }

      if $check == 0 { $valid = 0 }
    }

    if $valid == 1 {
      for @tmp.kv -> $i, $s {
        if %sorted{$i} {
          %sorted{$i}.push($s)
        } else {
          %sorted{$i} = [$s]
        }
      }
    }
  });

my %decoded;
my %ticket;
my $output;
while %rules {
  for %sorted.kv -> $i, @l {
    my $sum = 0;
    my $name;
    my $index;

    for %rules.kv -> $k, %v {
      my $check = 1;

      for @l -> $t {
        my $valid = 0;

        if ($t >= %v{"low"}[0] and $t <= %v{"low"}[1])
        or ($t >= %v{"high"}[0] and $t <= %v{"high"}[1]) {
          $valid = 1;
        }

        if $valid == 0 { $check = 0 }
      }

      if $check == 1 {
        $sum += $check;
        $name = $k;
        $index = $i;
      }
    }

    if $sum == 1 {
      #%decoded{$name} = $index;
      %sorted{$index} :delete;
      %rules{$name} :delete;

      #%ticket{$name} = @ticket[$index];
      if $name.contains('departure') { $output *= @ticket[$index] }
    }
  }
}

#say %decoded;
#say %ticket;
say $output;
