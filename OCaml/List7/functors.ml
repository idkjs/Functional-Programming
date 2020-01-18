module type OrderedType =
sig
  type t
  val compare : t -> t -> int
end

module OrderedList (X : OrderedType) =
  struct
    type t = X.t list

    let rec compare x y = match x, y with
      | x_hd :: x_tl, y_hd :: y_tl ->
        let compare_hd = Stdlib.compare x_hd y_hd
        in
        if compare_hd == 0 then compare x_tl y_tl
        else compare_hd
      | x_hd :: x_tl, [] -> 1
      | [], y_hd :: y_tl -> -1
      | _ -> 0
  end

module OrderedPair (X : OrderedType) =
  struct
    type t = X.t * X.t

    let compare (x_fst, x_snd) (y_fst, y_snd) =
      let compare_fst = Stdlib.compare x_fst y_fst
      in
      if compare_fst == 0 then Stdlib.compare x_snd y_snd
      else compare_fst 
  end

module OrderedOption (X : OrderedType) =
  struct
    type t = X.t option

    let compare x y = match x, y with
      | Some x_val, Some y_val -> Stdlib.compare x_val y_val
      | Some x_val, None -> 1
      | None, Some y_val -> -1
      | _ -> 0
  end