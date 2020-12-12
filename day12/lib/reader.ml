let read_whole_file filename =
  let ch = open_in filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s |> String.split_on_char '\n'
    |> List.map(fun order ->
        let a = (String.sub order 0 1) in
        let b = (String.sub order 1 ((String.length order) - 1)) in
        (a, (int_of_string b))
      )