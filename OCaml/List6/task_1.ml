exception StackOverflowError

let rec fix_with_limit n f x =
  if n > 0 then f (fix_with_limit (n - 1) f) x else raise StackOverflowError

let expected_rec_depth = 100

let fix_memo f x =
  let tbl = Hashtbl.create expected_rec_depth
  in
  let rec fix f x = if (Hashtbl.mem tbl x) then (Hashtbl.find tbl x)
    else begin 
      Hashtbl.add tbl x (f (fix f) x);
      (f (fix f) x)
    end
  in
  fix f x