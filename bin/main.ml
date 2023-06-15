open Delimcc_of_fxhandler

let main () =
  let p = new_prompt () in
  assert ([] = push_prompt p (fun () ->
                 1::2::take_subcont p (fun _k -> [])));
  assert ([1;2] = push_prompt p (fun () ->
                 1::2::take_subcont p (fun k -> push_subcont k [])));
  assert (135 =
    let p1 = new_prompt () in
    let p2 = new_prompt () in
    let p3 = new_prompt () in
    let pushtwice sk =
      sk (fun () ->
        sk (fun () ->
          shift0 p2 (fun sk2 -> sk2 (fun () ->
            sk2 (fun () -> 3))) ()))
     in
     push_prompt p1 (fun () ->
       push_prompt p2 (fun () ->
         push_prompt p3 (fun () -> shift0 p1 pushtwice ()) + 10) + 1) + 100)

let _ = main ()
