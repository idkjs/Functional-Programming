let rec foldr_cps = (cont, acc, lst, f) =>
  switch (lst) {
  | [hd, ...tl] => foldl_cps(a => cont(f(a, hd)), acc, tl, f)
  | [] => cont(acc)
  };

let foldr = (acc, lst, f) => foldl_cps(a => a, acc, lst, f);
