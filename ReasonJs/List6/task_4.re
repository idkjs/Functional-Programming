type stream('a) =
  | LNil
  | LCons('a, unit => stream('a));

let leibnitz_pi = {
  let rec leibnitz_helper = (acc, denom) => {
    let new_approx = acc +. 1. /. denom;

    let new_approx2 = new_approx -. 1. /. (denom +. 2.);
    [@implicit_arity]
    LCons(
      4. *. new_approx,
      fun
      | () =>
        [@implicit_arity]
        LCons(
          4. *. new_approx2,
          (
            fun
            | () => leibnitz_helper(new_approx2, denom +. 4.)
          ),
        ),
    );
  };
  leibnitz_helper(0., 1.);
};

let rec nth = (n, stream) =>
  switch (n, stream) {
  | (0, [@implicit_arity] LCons(lhd, _)) => lhd
  | (n, [@implicit_arity] LCons(_, ltl)) => nth(n - 1, ltl())
  | _ => failwith("InvalidArgumentException")
  };

let rec stream_triples = (stream, f) =>
  switch (stream) {
  | [@implicit_arity] LCons(x1, ltl1) =>
    switch (ltl1()) {
    | [@implicit_arity] LCons(x2, ltl2) =>
      switch (ltl2()) {
      | [@implicit_arity] LCons(x3, _) =>
        [@implicit_arity]
        LCons(
          f(x1, x2, x3),
          (
            fun
            | () => stream_triples(ltl1(), f)
          ),
        )
      }
    }
  };

let euler_transformation = (x, y, z) =>
  x -. (y -. z) *. (y -. z) /. (x -. 2. *. y +. z);
let euler_pi = stream_triples(leibnitz_pi, euler_transformation);
