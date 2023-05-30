
let read_lines name  =
  let ic = open_in name in
  let rec loop acc =
    try
      let line = input_line ic in
      loop (acc@[line])
    with End_of_file ->
      close_in ic;
      acc
  in
  String.concat "\n" (loop [])