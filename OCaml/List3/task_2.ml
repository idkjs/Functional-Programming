let dig_to_int lst =
  let rec helper lst acc =
    match lst with
    | hd :: tl -> helper tl (10 * acc + hd)
    | [] -> acc

  in helper lst 0

let dig_to_int_foldl lst = List.fold_left (fun a x -> 10 * a + x) 0 lst