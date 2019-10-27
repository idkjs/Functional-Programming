let for_all_exc p lst = 
  try List.fold_left (fun a x -> if not (p x) then raise (Failure "Not all") else true) true lst with
  | (Failure "Not all") -> false

let mult_list_exc lst =
  try List.fold_left (fun a x -> if x == 0 then raise (Failure "Result 0") else a * x) 1 lst with
  | (Failure "Result 0") -> 0

let sorted_exc lst =
  (* Assume that 0 is the smallest number *)
  let result =
    try List.fold_left (fun a x -> if a >= x then raise (Failure "Desc order") else x) 0 lst with
    | (Failure "Desc order") -> 0
  in if result > 0 then true else false