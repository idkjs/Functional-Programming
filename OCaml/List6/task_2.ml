let reset () = try next () with Error -> 

let rec next () = try next () + 1 with Error -> reset ()