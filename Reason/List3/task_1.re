let fold_len = lst => List.fold_left((a, x) => a + 1, 0, lst);

let fold_rev = lst => List.fold_left((a, x) => [x, ...a], [], lst);

let fold_map = (f, lst) =>
  List.fold_right((x, a) => [f(x), ...a], lst, []);

let fold_append = (lstl, lstr) =>
  List.fold_right((x, a) => [x, ...a], lstl, lstr);

let fold_filter = (p, lst) =>
  List.fold_right(
    (x, a) =>
      if (p(x)) {
        [x, ...a];
      } else {
        a;
      },
    lst,
    [],
  );

let fold_rev_map = (f, lst) =>
  List.fold_left((a, x) => [f(x), ...a], [], lst);
