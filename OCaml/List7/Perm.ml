module type OrderedType =
sig
  type t
  val compare : t -> t -> int
end

module type S =
sig
  type key
  type t

  val apply : t -> key -> key
  val id : t
  val invert : t -> t
  val swap : key -> key -> t
  val compose : t -> t -> t
  val compare : t -> t -> int
end

module Make(Key : OrderedType) =
  struct
    module MyMap = Map.Make(Key)

    type key = Key.t
    type t = key MyMap.t * key MyMap.t

    let apply (sigma, sigma_inv) x =
    match MyMap.find_opt x sigma with
      | Some value -> value
      | None -> x

    let id = MyMap.empty, MyMap.empty  

    let invert (sigma, sigma_inv) = sigma_inv, sigma

    let swap x y = if Key.compare x y == 0 then MyMap.empty, MyMap.empty else
      let sigma = MyMap.singleton x y |> MyMap.add y x
      in (sigma, sigma)

    let compose (sigma1, sigma1_inv) (sigma2, sigma2_inv) =
      let tmp = MyMap.merge (fun key s1 s2 -> match s1, s2 with
        | Some s1, Some s2 -> Some (s1, s2)
        | None, Some s2 -> Some (key, s2)
        | Some s1, None -> Some (s1, key)
        | _ -> None
      ) sigma1_inv sigma2_inv
      in
      let composed = MyMap.fold
        (fun key (old_key, new_val) acc ->
          if old_key == new_val then acc else MyMap.add old_key new_val acc)
        tmp MyMap.empty
      in composed, composed

    let compare (sigma1, sigma1_inv) (sigma2, sigma2_inv) =
      MyMap.compare Key.compare sigma1 sigma2
 end