module type OrderedType = {
  type t;
  let compare: (t, t) => int;
};

module type S = {
  type key;
  type t;

  let apply: (t, key) => key;
  let id: t;
  let invert: t => t;
  let swap: (key, key) => t;
  let compose: (t, t) => t;
  let compare: (t, t) => int;
};

module Make = (Key: OrderedType) => {
  module MyMap = Map.Make(Key);

  type key = Key.t;
  type t = (MyMap.t(key), MyMap.t(key));

  let apply = ((sigma, sigma_inv), x) =>
    switch (MyMap.find_opt(x, sigma)) {
    | Some(value) => value
    | None => x
    };

  let id = (MyMap.empty, MyMap.empty);

  let invert = ((sigma, sigma_inv)) => (sigma_inv, sigma);

  let swap = (x, y) =>
    if (Key.compare(x, y) === 0) {
      (MyMap.empty, MyMap.empty);
    } else {
      let sigma = MyMap.singleton(x, y) |> MyMap.add(y, x);
      (sigma, sigma);
    };

  let compose = ((sigma1, sigma1_inv), (sigma2, sigma2_inv)) => {
    let tmp =
      MyMap.merge(
        (key, s1, s2) =>
          switch (s1, s2) {
          | (Some(s1), Some(s2)) => Some((s1, s2))
          | (None, Some(s2)) => Some((key, s2))
          | (Some(s1), None) => Some((s1, key))
          | _ => None
          },
        sigma1_inv,
        sigma2_inv,
      );

    let composed =
      MyMap.fold(
        (key, (old_key, new_val), acc) =>
          if (old_key === new_val) {
            acc;
          } else {
            MyMap.add(old_key, new_val, acc);
          },
        tmp,
        MyMap.empty,
      );
    (composed, composed);
  };

  let compare = ((sigma1, sigma1_inv), (sigma2, sigma2_inv)) =>
    MyMap.compare(Key.compare, sigma1, sigma2);
};
