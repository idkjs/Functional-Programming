let rec polynomial = (lst, x0) =>
  switch (lst) {
  | [hd, ...tl] => hd + x0 * polynomial(tl, x0)
  | [] => 0
  };

let polynomial_foldr = (lst, x0) =>
  List.fold_right((x, a) => a * x0 + x, lst, 0);

let polynomial_tail_rec = (lst, x0) => {
  let rec helper = (lst, acc, pow) =>
    switch (lst) {
    | [hd, ...tl] => helper(tl, acc + hd * pow, pow * x0)
    | [] => acc
    };
  helper(lst, 0, 1);
};

let polynomial_foldl = (lst, x0) => {
  let range_lst = n => {
    let rec helper = iter =>
      if (iter === n) {
        [];
      } else {
        [iter, ...helper(iter + 1)];
      };
    helper(0);
  };

  let enumerate_lst = lst => List.combine(lst, range_lst(List.length(lst)));

  let pow = (x, n) => {
    let rec helper = iter =>
      if (iter === n) {
        1;
      } else {
        x * helper(iter + 1);
      };
    helper(0);
  };

  List.fold_left(
    (acc, x) => {
      let (a, n) = x;
      acc + a * pow(x0, n);
    },
    0,
    enumerate_lst(lst),
  );
};
