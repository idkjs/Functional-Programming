module type OrderedType = {
  type t;
  let compare: (t, t) => int;
};

module OrderedList = (X: OrderedType) => {
  type t = list(X.t);

  let rec compare = (x, y) =>
    switch (x, y) {
    | ([x_hd, ...x_tl], [y_hd, ...y_tl]) =>
      let compare_hd = Stdlib.compare(x_hd, y_hd);

      if (compare_hd === 0) {
        compare(x_tl, y_tl);
      } else {
        compare_hd;
      };
    | ([x_hd, ...x_tl], []) => 1
    | ([], [y_hd, ...y_tl]) => (-1)
    | _ => 0
    };
};

module OrderedPair = (X: OrderedType) => {
  type t = (X.t, X.t);

  let compare = ((x_fst, x_snd), (y_fst, y_snd)) => {
    let compare_fst = Stdlib.compare(x_fst, y_fst);

    if (compare_fst === 0) {
      Stdlib.compare(x_snd, y_snd);
    } else {
      compare_fst;
    };
  };
};

module OrderedOption = (X: OrderedType) => {
  type t = option(X.t);

  let compare = (x, y) =>
    switch (x, y) {
    | (Some(x_val), Some(y_val)) => Stdlib.compare(x_val, y_val)
    | (Some(x_val), None) => 1
    | (None, Some(y_val)) => (-1)
    | _ => 0
    };
};
