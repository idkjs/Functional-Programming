let sublists lst =
  let rec helper lst acc = 
    match lst with
    | [] -> acc
    | hd::tl -> helper tl (List.flatten (List.map (fun sublst -> [hd :: sublst; sublst]) acc))
  in helper (List.rev lst) [[]];;