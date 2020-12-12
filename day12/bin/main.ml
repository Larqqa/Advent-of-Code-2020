open Lib
open Core.Std

let () = print_endline "Hello ocaml!"

let r file = In_channel.read_lines file


(* let () =
  let result = Math.add 2 3 in
  print_endline (string_of_int result);
  let result = Math.sub 3 1 in
  print_endline (string_of_int result) *)