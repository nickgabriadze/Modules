```ocaml
module type Readable = sig
type t
type arg
val begin_read : arg -> t
val end_read : t -> unit
val at_end : t -> bool
val read_line : t -> (t * string)
end
```

to describe a source from which we can read text line by line. Notice, that the arg type is a means for the implementation to specifiy the argument it needs to initialize reading with begin_read. While at_end checks whether reading reached the end of the input, read_line is used to read the next line (text until next newline character '\n') and move the reading position forward.

1. Implement a module ReadableString, that is of type Readable and is used to read from a string. The string is given to begin_read.
2. Implement a module ReadableFile, that is of type Readable and allows to read from a file. The name of the file is given to begin_read.
3. Implement a functor Reader that extends a given Readable such that all types
and values of the Readable are also available on the Reader. Furthermore, it provides a function read_all : t -> (t * string) that reads the entire text that is available.

