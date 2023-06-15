type 'a prompt
type ('a,'b) subcont

val new_prompt   : unit -> 'a prompt
val push_prompt  : 'a prompt -> (unit -> 'a) -> 'a
val take_subcont : 'b prompt -> (('a,'b) subcont -> 'b) -> 'a
val push_subcont : ('a,'b) subcont -> 'a -> 'b

(* Assorted control operators *)
val reset    : ('a prompt -> 'a) -> 'a
val shift    : 'a prompt -> (('b -> 'a) -> 'a) -> 'b
val control  : 'a prompt -> (('b -> 'a) -> 'a) -> 'b
val shift0   : 'a prompt -> (('b -> 'a) -> 'a) -> 'b
val control0 : 'a prompt -> (('b -> 'a) -> 'a) -> 'b
val abort    : 'a prompt -> 'a -> 'b
