open Effect
open Effect.Deep

type ('a,'b) subcont = ('a,'b) continuation

type 'a prompt = {
  take  : 'b. (('b, 'a) subcont -> 'a) -> 'b;
  push  : (unit -> 'a) -> 'a;
}

let new_prompt (type a) () : a prompt =
  let module M = struct type _ Effect.t += Prompt : (('b,a) subcont -> a) -> 'b t end in
  let take f  = perform (M.Prompt f) in
  let push f  =
    try_with f ()
    { effc = fun (type a) (e: a Effect.t) ->
        match e with
        | M.Prompt f -> Some (fun (k: (a,_) continuation) ->
            Gc.finalise (fun k -> Multicont.Deep.drop_continuation k) k;
            f k)
        | _ -> None }
  in
  { take; push }

let push_prompt {push; _} = push
let take_subcont {take; _} = take
let push_subcont k v =
  let k' = Multicont.Deep.clone_continuation k in
  continue k' v

(** For the details of the implementation of control and shift0, see
    https://hackage.haskell.org/package/CC-delcont-0.2.1.0/docs/src/Control-Monad-CC.html *)
let reset e = let p = new_prompt () in push_prompt p (fun () -> e p)
let shift p f = take_subcont p (fun sk ->
    push_prompt p (fun () -> f (fun c -> push_prompt p (fun () -> push_subcont sk c))))
let control p f = take_subcont p (fun sk ->
    push_prompt p (fun () -> f (fun c -> push_subcont sk c)))
let shift0 p f = take_subcont p (fun sk ->
    f (fun c -> push_prompt p (fun () -> push_subcont sk c)))
let control0 p f = take_subcont p (fun sk ->
    f (fun c -> push_subcont sk c))
let abort p e = take_subcont p (fun _ -> e)
