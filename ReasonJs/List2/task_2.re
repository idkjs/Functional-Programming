let rec cycle = (lst, n) => {
  let rec helper = (lst, n) =>
    if (n === 0) {
      lst;
    } else {
      helper(List.tl(lst) @ [List.hd(lst)], n - 1);
    };
  helper(lst, List.length(lst) - n);
};
