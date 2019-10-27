let rec foldr_cps cont acc lst f =
  match lst with
  | hd::tl -> foldl_cps (fun a -> cont (f a hd)) acc tl f
  | [] -> cont acc

let foldr acc lst f = foldl_cps (fun a -> a) acc lst f