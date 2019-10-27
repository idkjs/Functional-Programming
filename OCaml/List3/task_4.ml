let rec polynomial lst x0 =
  match lst with
  | hd :: tl -> hd + x0 * (polynomial tl x0)
  | [] -> 0

let polynomial_foldr lst x0 = List.fold_right (fun x a -> a * x0 + x) lst 0

let polynomial_tail_rec lst x0 =
  let rec helper lst acc pow = 
    match lst with
    | hd ::tl -> helper tl (acc + hd * pow) (pow * x0)
    | [] -> acc
  in helper lst 0 1

let polynomial_foldl lst x0 =
  let range_lst n =
    let rec helper iter = if iter == n then [] else iter :: (helper (iter + 1))
  in helper 0

  in
  let enumerate_lst lst = List.combine lst (range_lst (List.length lst))

  in
  let pow x n =
    let rec helper iter = if iter == n then 1 else x * (helper (iter + 1))
  in helper 0

  in
  List.fold_left (fun acc x -> let (a, n) = x in acc + a * (pow x0 n)) 0 (enumerate_lst lst)