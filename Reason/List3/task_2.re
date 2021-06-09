let dig_to_int = lst => {
  let rec helper = (lst, acc) =>
    switch (lst) {
    | [hd, ...tl] => helper(tl, 10 * acc + hd)
    | [] => acc
    };

  helper(lst, 0);
};

let dig_to_int_foldl = lst => List.fold_left((a, x) => 10 * a + x, 0, lst);
