let horner lst x0 =
  let rec helper lst acc =
    match lst with
    | hd :: tl -> helper tl (acc * x0 + hd)
    | [] -> acc
  in helper lst 0

let horner_foldl lst x0 = List.fold_left (fun a x -> a * x0 + x) 0 lst