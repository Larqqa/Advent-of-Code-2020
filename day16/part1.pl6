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

    %(@tmp[0] => @tmp[1]);
  });

my @ticket = @r[1].split("\n")[1]
  .split(",");

my @nearby = @r[2].split(":")[1]
  .split("\n") :skip-empty
  .map(-> $row { $row.split("\n") })
  .map(-> $row { $row.split(",") });

my @rejected;
for @nearby -> @single {
  #say @single;
  for @single -> $t {
    my $checks = 0;
    for %rules.kv -> $k, @v {
      # say "{$k} {@v}\n";
      if ($t >= @v[0][0] and $t <= @v[0][1]) or ($t >= @v[1][0] and $t <= @v[1][1]) {
        $checks = 1;
        last;
      }
    }
    if $checks == 0 {
      @rejected.push($t);
    }
  }
}

say @rejected.sum;