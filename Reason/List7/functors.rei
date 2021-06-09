module type OrderedType = {
  type t;
  let compare: (t, t) => int;
};

module OrderedList: (X: OrderedType) => OrderedType with type t = list(X.t);
module OrderedPair: (X: OrderedType) => OrderedType with type t = (X.t, X.t);
module OrderedOption:
  (X: OrderedType) => OrderedType with type t = option(X.t);
