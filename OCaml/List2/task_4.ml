let put_each_gap x lst =
  let rec helper x bef aft acc =
    match aft with
    | [] -> (bef @ [x]) :: acc
    | hd::tl -> helper x (bef @ [hd]) tl ((bef @ [x] @ aft) :: acc)
  in helper x [] lst []

let perms lst =
  let rec helper lst acc =
    match lst with
    | [] -> acc
    | hd::tl -> helper tl (List.flatten (List.map (fun perm -> put_each_gap hd perm) acc))
  in helper lst [[]];;