module type OrderedType = {
  type t;
  let compare: (t, t) => int;
};

module PermGen = (Key: OrderedType) => {
  module MyPerm = Perm.Make(Key);
  module MySet = Set.Make(MyPerm);

  let cart_self_prod = (gens: MySet.t): list((MyPerm.t, MyPerm.t)) => {
    let gens_lst = MySet.fold((perm, acc) => [perm, ...acc], gens, []);

    List.fold_left(
      (acc1, perm1) =>
        List.fold_left(
          (acc2, perm2) => [(perm1, perm2), ...acc2],
          acc1,
          gens_lst,
        ),
      [],
      gens_lst,
    );
  };

  let gen_next_gens = (gens: MySet.t): MySet.t =>
    MySet.union(
      MySet.map(MyPerm.invert, gens),
      MySet.of_list(
        List.map(
          ((perm1, perm2)) => MyPerm.compose(perm1, perm2),
          cart_self_prod(gens),
        ),
      ),
    );

  let is_generated = (perm: MyPerm.t, gens: list(MyPerm.t)) => {
    let rec check_next_perms = prev_gens => {
      let next_gens = gen_next_gens(prev_gens);

      switch (MySet.find_opt(perm, next_gens)) {
      | Some(_) => true
      | None =>
        if (MySet.compare(prev_gens, next_gens) === 0) {
          false;
        } else {
          check_next_perms(next_gens);
        }
      };
    };
    check_next_perms(MySet.of_list(gens));
  };
};
