/* Church encoding */

let zero = (_, x) => x;

let succ = (n, f, x) => f(n(f, x));

let add = (m, n, f, x) => m(f, n(f, x));

let mul = (m, n, f, x) => m(n(f), x);

let is_zero = n => n(_ => false, true);

let cnum_of_int = n =>
  switch (n) {
  | 0 => ((f, x) => x)
  | _ => ((f, x) => f(cnum_of_int(n - 1, f, x)))
  };

let int_of_cnum = cn => cn((+)(1), 0);
