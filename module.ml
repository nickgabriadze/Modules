module type Readable = sig
  type t
  type arg
  val begin_read : arg -> t 
  val end_read : t -> unit
  val at_end : t -> bool
  val read_line : t -> (t * string)   

end


module ReadableString:Readable with type arg = string = struct
  type t = {myString: string list; startingAt: int}
  type arg = string

  let begin_read str = {myString = String.split_on_char '\n' (str); startingAt = 0}

  let read_line myT = 
    let rec iterateOver lst index tracker = match lst with
    | [] -> failwith "no more to read"
    | x::xs -> if tracker = index then ({myString = myT.myString; startingAt = tracker + 1}, x) else
      iterateOver xs index (tracker+1)
    in iterateOver myT.myString myT.startingAt 0


  let at_end myT = if myT.startingAt = (List.length myT.myString) then true else false;;

  let end_read myT = ()
end 


let rs = ReadableString.begin_read "A multiline\ntext"
let e = ReadableString.at_end rs;;
let rs,l1 = ReadableString.read_line rs;;
let rs,l2 = ReadableString.read_line rs;;
let e = ReadableString.at_end rs;;
let _ = ReadableString.end_read rs;;

module ReadableFile:Readable with type arg = string = struct 

  type t = {myString: string list; startingAt: int}
  type arg = string


  let begin_read str = {
        myString = String.split_on_char '\n' 
      (In_channel.with_open_bin str In_channel.input_all); 
      startingAt = 0}

  let read_line myT = 
    let rec iterateOver lst index tracker = match lst with
    | [] -> failwith "no more to read"
    | x::xs -> if tracker = index then ({myString = myT.myString; startingAt = tracker + 1}, x) else
      iterateOver xs index (tracker+1)
    in iterateOver myT.myString myT.startingAt 0

  let at_end myT = if myT.startingAt = (List.length myT.myString) then true else false;;
  let end_read myT = ()
end



let rs = ReadableFile.begin_read "example.txt"
let e = ReadableFile.at_end rs;;
let rs,l1 = ReadableFile.read_line rs;;
let rs,l2 = ReadableFile.read_line rs;;
let rs,l3 = ReadableFile.read_line rs;;
let e = ReadableFile.at_end rs;;
let _ = ReadableFile.end_read rs;;


module Reader(R:Readable) = struct 
  type t = R.t
  type arg = R.arg
  
  let begin_read str = R.begin_read str
  let end_read t = R.end_read t
  let read_line t = R.read_line t
  let at_end t = R.at_end t

 let read_all t = 
  let rec read_each_line acc myT=
    if R.at_end myT then acc else
    read_each_line (acc@[(snd (R.read_line myT))]) (fst (R.read_line myT))
  in (t, String.concat "\n" (read_each_line [] t))
end


module R = Reader(ReadableString);;
let r = R.begin_read "A multiline\ntext";;
let r,t = R.read_all r;;
let _ = R.end_read r;;