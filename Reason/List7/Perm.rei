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

module Make: (Key: OrderedType) => S with type key = Key.t;
