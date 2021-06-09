let sublists = lst => {
  let rec helper = (lst, acc) =>
    switch (lst) {
    | [] => acc
    | [hd, ...tl] =>
      helper(
        tl,
        List.flatten(List.map(sublst => [[hd, ...sublst], sublst], acc)),
      )
    };
  helper(List.rev(lst), [[]]);
};
