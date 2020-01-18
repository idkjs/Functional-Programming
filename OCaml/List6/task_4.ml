type 'a stream = LNil | LCons of 'a * (unit -> 'a stream)

let leibnitz_pi = 
  let rec leibnitz_helper acc denom =
    let new_approx = (acc +. 1. /. denom)
    in 
    let new_approx2 = (new_approx -. 1. /. (denom +. 2.))
    in LCons (4. *. new_approx,
              function () -> LCons (4. *. new_approx2,
                                    function () -> leibnitz_helper new_approx2 (denom +. 4.)))
  in leibnitz_helper 0. 1.

let rec nth n stream = match (n, stream) with
    (0, LCons (lhd, _)) -> lhd
  | (n, LCons (_, ltl)) -> nth (n - 1) (ltl ())
  | _ -> failwith "InvalidArgumentException"

let rec stream_triples stream f = match stream with 
  LCons (x1, ltl1) -> match (ltl1 ()) with
    LCons (x2, ltl2) -> match (ltl2 ()) with
      LCons (x3, _) -> LCons (f x1 x2 x3, function () -> stream_triples (ltl1 ()) f)

let euler_transformation x y z = x -. ((y -. z) *. (y -. z)) /. (x -. 2. *. y +. z)
let euler_pi = stream_triples leibnitz_pi euler_transformation