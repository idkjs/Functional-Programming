type formula =
  | False
  | Var of string
  | Impl of formula * formula

let rec string_of_formula (f: formula) =
  let simple_impl (l: formula) (r: formula) = String.concat " " [
    "(";
    string_of_formula l;
    "→";
    string_of_formula r;
    ")";
  ]
  in
  match f with
  | Impl (Impl (l, r), g) -> String.concat " " [simple_impl l r; "→"; string_of_formula r]
  | Impl (l, r) -> String.concat " " [string_of_formula l; "→"; string_of_formula r]
  | Var (var_name) -> var_name
  | False -> "⊥"

let pp_print_formula fmtr f =
  Format.pp_print_string fmtr (string_of_formula f)

type impl = Impl of formula * formula
type ('a, 'b, 'c) node = { assumptions: 'a list; consequence: 'b; children: 'c list}
type ('a, 'b) leaf = { assumptions: 'a list; consequence: 'b } 

(* Schema: concl_assump * concl_reason * children (if any) *)
type theorem =
  | Ax of (formula, formula) leaf
  | I of (formula, impl, theorem) node
  | E of (formula list, formula, theorem) node
  | EFalse of (formula, formula, theorem) node

let assumptions thm = thm.assumptions

let consequence thm = thm.consequence

let pp_print_theorem fmtr thm =
  let open Format in
  pp_open_hvbox fmtr 2;
  begin match assumptions thm with
  | [] -> ()
  | f :: fs ->
    pp_print_formula fmtr f;
    fs |> List.iter (fun f ->
      pp_print_string fmtr ",";
      pp_print_space fmtr ();
      pp_print_formula fmtr f);
    pp_print_space fmtr ()
  end;
  pp_open_hbox fmtr ();
  pp_print_string fmtr "⊢";
  pp_print_space fmtr ();
  pp_print_formula fmtr (consequence thm);
  pp_close_box fmtr ();
  pp_close_box fmtr ()

let by_assumption (f: formula) = Ax { assumptions: [f]; consequences: f }

let imp_i f thm =
  (* TODO: zaimplementuj *)
  failwith "not implemented"

let imp_e th1 th2 =
  (* TODO: zaimplementuj *)
  failwith "not implemented"

let bot_e f thm =
  (* TODO: zaimplementuj *)
  failwith "not implemented"
