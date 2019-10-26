(* int -> int *)
let f (x: int) = x;;

(* ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b *)
let f g h x = g (h x);;

(* 'a -> 'b -> 'a *)
let f x _ = x;;

(* 'a -> 'a -> 'a *)
let rec f x y = 
  match x with
  | y -> x
  | _ -> y;;