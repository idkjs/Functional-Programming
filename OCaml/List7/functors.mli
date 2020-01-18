module type OrderedType =
sig
  type t
  val compare : t -> t -> int
end

module OrderedList (X : OrderedType) : OrderedType with type t = X.t list
module OrderedPair (X: OrderedType) : OrderedType with type t = X.t * X.t
module OrderedOption (X : OrderedType) : OrderedType with type t = X.t option