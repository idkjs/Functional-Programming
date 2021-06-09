let horner = (lst, x0) => {
  let rec helper = (lst, acc) =>
    switch (lst) {
    | [hd, ...tl] => helper(tl, acc * x0 + hd)
    | [] => acc
    };
  helper(lst, 0);
};

let horner_foldl = (lst, x0) =>
  List.fold_left((a, x) => a * x0 + x, 0, lst);
