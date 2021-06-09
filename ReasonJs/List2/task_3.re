let rec merge = (cmp, lst1, lst2) =>
  switch (lst1, lst2) {
  | ([], _) => lst2
  | (_, []) => lst1
  | ([hd1, ...tl1], [hd2, ...tl2]) =>
    if (cmp(hd1, hd2)) {
      [hd1, ...merge(cmp, tl1, lst2)];
    } else {
      [hd2, ...merge(cmp, lst1, tl2)];
    }
  };

let merge_tail_rec = (cmp, lst1, lst2) => {
  let rec helper = (cmp, lst1, lst2, acc) =>
    switch (lst1, lst2) {
    | ([], _) => acc @ lst2
    | (_, []) => acc @ lst1
    | ([hd1, ...tl1], [hd2, ...tl2]) =>
      if (cmp(hd1, hd2)) {
        helper(cmp, tl1, lst2, acc @ [hd1]);
      } else {
        helper(cmp, lst1, tl2, acc @ [hd2]);
      }
    };
  helper(cmp, lst1, lst2, []);
};

let split = lst => {
  let rec helper = (acc1, acc2, lst) =>
    switch (lst) {
    | [] => [acc1, acc2]
    | [el1] => [[el1, ...acc1], acc2]
    | [el1, el2, ...tail] => helper([el1, ...acc1], [el2, ...acc2], tail)
    };
  helper([], [], lst);
};

let rec mergesort = lst =>
  if (List.length(lst) <= 1) {
    lst;
  } else {
    let splitted = split_lst_half(lst);
    merge(
      (<=),
      mergesort(List.nth(splitted, 0)),
      mergesort(List.nth(splitted, 1)),
    );
  };
