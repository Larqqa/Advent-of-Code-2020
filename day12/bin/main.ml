open Lib
open Printf

(* let () =
  print_endline Sys.argv.(1) *)

let orders = Reader.read_whole_file "./resources/input" ;;
(* let() = Helpers.print_tuple_list orders ;; *)

let wPos= ref [|10; -1|];;
let sPos = ref [|0; 0|];;
let dir = ref 90;;

let countAngle direction =
  if direction > 360 then
    direction - 360
  else if direction <= 0 then
    360 + direction
  else
    direction

let doNavigation =
  fun (ord, amo) ->
    match (ord, amo) with
    | ("N", _) -> sPos := [|!sPos.(0); !sPos.(1) - amo|]
    | ("S", _) -> sPos := [|!sPos.(0); !sPos.(1) + amo|]
    | ("W", _) -> sPos := [|!sPos.(0) - amo; !sPos.(1)|]
    | ("E", _) -> sPos := [|!sPos.(0) + amo; !sPos.(1)|]
    | ("R", _) -> dir := countAngle (!dir + amo)
    | ("L", _) -> dir := countAngle (!dir - amo)
    | ("F", _) -> if !dir == 90  then sPos := [|!sPos.(0) + amo; !sPos.(1)|]
             else if !dir == 180 then sPos := [|!sPos.(0); !sPos.(1) + amo|]
             else if !dir == 270 then sPos := [|!sPos.(0) - amo; !sPos.(1)|]
             else if !dir == 360 then sPos := [|!sPos.(0); !sPos.(1) - amo|]
    | _        -> ();
    ();;

let pi = 2.0 *. acos 0.0;;

let changeAngle a =
  dir := countAngle (!dir + a);
  match a with
    | -90  -> wPos := [|(- !wPos.(1)); !wPos.(0)|]
    | -180 -> wPos := [|(- !wPos.(0)); (- !wPos.(1))|]
    | -270 -> wPos := [|!wPos.(1); (- !wPos.(0))|]
    | 90   -> wPos := [|!wPos.(1); (- !wPos.(0))|]
    | 180  -> wPos := [|(- !wPos.(0)); (- !wPos.(1))|]
    | 270  -> wPos := [|(- !wPos.(1)); !wPos.(0)|]
    | _    -> ();
  ();;

let doNavigation2 =
  fun (ord, amo) ->
    match (ord, amo) with
    | ("N", _) -> wPos := [|!wPos.(0); !wPos.(1) - amo|]
    | ("S", _) -> wPos := [|!wPos.(0); !wPos.(1) + amo|]
    | ("W", _) -> wPos := [|!wPos.(0) - amo; !wPos.(1)|]
    | ("E", _) -> wPos := [|!wPos.(0) + amo; !wPos.(1)|]
    | ("R", _) -> changeAngle (- amo)
    | ("L", _) -> changeAngle amo
    | ("F", _) -> sPos := [|!sPos.(0) + (!wPos.(0) * amo); !sPos.(1) + (!wPos.(1) * amo)|]
    | _        -> ();
    ();;


printf "%i %i %i\n" !wPos.(0) !wPos.(1)!dir
let navigation orders =
  List.map(fun (ord, amo) ->
    doNavigation (ord, amo)
  ) orders;;

(* navigation orders ;;
printf "%i %i %i\n" !x !y !dir;;
print_int (!x + !y) *)

let navigation2 orders =
  List.map(fun (ord, amo) ->
    doNavigation2 (ord, amo)
  ) orders;;

printf "%i %i %i\n" !wPos.(0) !wPos.(1) !dir;
navigation2 orders ;;
printf "%i %i %i\n" !wPos.(0) !wPos.(1)!dir;
printf "%i %i %i\n" !sPos.(0) !sPos.(1)!dir
