module type Readable =
  sig
    type t
    type arg
    val begin_read : arg -> t
    val end_read : t -> unit
    val at_end : t -> bool
    val read_line : t -> t * string
  end
module ReadableString :
  sig
    type t
    type arg = string
    val begin_read : arg -> t
    val end_read : t -> unit
    val at_end : t -> bool
    val read_line : t -> t * string
  end
val rs : ReadableString.t
val e : bool
val rs : ReadableString.t
val l1 : string
val rs : ReadableString.t
val l2 : string
val e : bool
module ReadableFile :
  sig
    type t
    type arg = string
    val begin_read : arg -> t
    val end_read : t -> unit
    val at_end : t -> bool
    val read_line : t -> t * string
  end
val rs : ReadableFile.t
val e : bool
val rs : ReadableFile.t
val l1 : string
val rs : ReadableFile.t
val l2 : string
val rs : ReadableFile.t
val l3 : string
val e : bool
module Reader :
  functor (R : Readable) ->
    sig
      type t = R.t
      type arg = R.arg
      val begin_read : R.arg -> R.t
      val end_read : R.t -> unit
      val read_line : R.t -> R.t * string
      val at_end : R.t -> bool
      val read_all : R.t -> R.t * string
    end
module R :
  sig
    type t = ReadableString.t
    type arg = string
    val begin_read : string -> ReadableString.t
    val end_read : ReadableString.t -> unit
    val read_line : ReadableString.t -> ReadableString.t * string
    val at_end : ReadableString.t -> bool
    val read_all : ReadableString.t -> ReadableString.t * string
  end
val r : ReadableString.t
val r : ReadableString.t
val t : string
