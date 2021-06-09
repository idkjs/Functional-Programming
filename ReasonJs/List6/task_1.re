exception StackOverflowError;

let rec fix_with_limit = (n, f, x) =>
  if (n > 0) {
    f(fix_with_limit(n - 1, f), x);
  } else {
    raise(StackOverflowError);
  };

let expected_rec_depth = 100;

let fix_memo = (f, x) => {
  let tbl = Hashtbl.create(expected_rec_depth);

  let rec fix = (f, x) =>
    if (Hashtbl.mem(tbl, x)) {
      Hashtbl.find(tbl, x);
    } else {
      Hashtbl.add(tbl, x, f(fix(f), x));
      f(fix(f), x);
    };

  fix(f, x);
};
