let rec print_tuple_list =
  function
  | [] -> ()
  | (a, b) :: rest ->
    Printf.printf "%s, %i; " a b;
    print_tuple_list rest

let rec print_list =
  function [] -> ()
  | a :: rest ->
    print_endline a;
    print_list rest