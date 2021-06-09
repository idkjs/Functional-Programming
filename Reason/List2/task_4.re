let put_each_gap = (x, lst) => {
  let rec helper = (x, bef, aft, acc) =>
    switch (aft) {
    | [] => [bef @ [x], ...acc]
    | [hd, ...tl] => helper(x, bef @ [hd], tl, [bef @ [x] @ aft, ...acc])
    };
  helper(x, [], lst, []);
};

let perms = lst => {
  let rec helper = (lst, acc) =>
    switch (lst) {
    | [] => acc
    | [hd, ...tl] =>
      helper(
        tl,
        List.flatten(List.map(perm => put_each_gap(hd, perm), acc)),
      )
    };
  helper(lst, [[]]);
};
