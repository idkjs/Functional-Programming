let for_all_exc = (p, lst) =>
  try(
    List.fold_left(
      (a, x) =>
        if (!p(x)) {
          raise(Failure("Not all"));
        } else {
          true;
        },
      true,
      lst,
    )
  ) {
  | Failure("Not all") => false
  };

let mult_list_exc = lst =>
  try(
    List.fold_left(
      (a, x) =>
        if (x === 0) {
          raise(Failure("Result 0"));
        } else {
          a * x;
        },
      1,
      lst,
    )
  ) {
  | Failure("Result 0") => 0
  };

let sorted_exc = lst => {
  /* Assume that 0 is the smallest number */
  let result =
    try(
      List.fold_left(
        (a, x) =>
          if (a >= x) {
            raise(Failure("Desc order"));
          } else {
            x;
          },
        0,
        lst,
      )
    ) {
    | Failure("Desc order") => 0
    };
  if (result > 0) {
    true;
  } else {
    false;
  };
};
