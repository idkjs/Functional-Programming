module type OrderedType =
sig
  type t
  val compare : t -> t -> int
end

module PermGen (Key : OrderedType) =
  struct
    module MyPerm = Perm.Make(Key)
    module MySet = Set.Make(MyPerm)

    let cart_self_prod (gens : MySet.t) : (MyPerm.t * MyPerm.t) list =
      let gens_lst = MySet.fold (fun perm acc -> perm :: acc) gens []
      in
      List.fold_left (fun acc1 perm1 ->
        List.fold_left (fun acc2 perm2 -> (perm1, perm2) :: acc2) acc1 gens_lst) [] gens_lst

    let gen_next_gens (gens : MySet.t) : MySet.t = MySet.union
      (MySet.map
        MyPerm.invert
        gens)
      (MySet.of_list
        (List.map
          (fun (perm1, perm2) -> MyPerm.compose perm1 perm2)
          (cart_self_prod gens)))
    
    let is_generated (perm : MyPerm.t) (gens : MyPerm.t list) =
      let rec check_next_perms prev_gens =
        let next_gens = gen_next_gens prev_gens
        in
        match MySet.find_opt perm next_gens with
          | Some _ -> true
          | None ->
            if (MySet.compare prev_gens next_gens) == 0 then false
            else check_next_perms next_gens 
      in check_next_perms (MySet.of_list gens)
  end