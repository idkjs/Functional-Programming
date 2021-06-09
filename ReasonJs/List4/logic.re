type formula =
  | False
  | Var(string)
  | Impl(formula, formula);

let rec string_of_formula = (f: formula) => {
  let simple_impl = (l: formula, r: formula) =>
    String.concat(
      " ",
      ["(", string_of_formula(l), "→", string_of_formula(r), ")"],
    );

  switch (f) {
  |  Impl( Impl(l, r), g) =>
    String.concat(" ", [simple_impl(l, r), "→", string_of_formula(r)])
  |  Impl(l, r) =>
    String.concat(" ", [string_of_formula(l), "→", string_of_formula(r)])
  | Var(var_name) => var_name
  | False => "⊥"
  };
};

let pp_print_formula = (fmtr, f) =>
  Format.pp_print_string(fmtr, string_of_formula(f));

type impl =
  | Impl(formula, formula);
type node('a, 'b, 'c) = {
  assumptions: list('a),
  consequence: 'b,
  children: list('c),
};
type leaf('a, 'b) = {
  assumptions: list('a),
  consequence: 'b,
};

/* Schema: concl_assump * concl_reason * children (if any) */
type theorem =
  | Ax(leaf(formula, formula))
  | I(node(formula, impl, theorem))
  | E(node(list(formula), formula, theorem))
  | EFalse(node(formula, formula, theorem));

let assumptions = thm => thm.assumptions;

let consequence = thm => thm.consequence;

let pp_print_theorem = (fmtr, thm) => {
  open Format;
  pp_open_hvbox(fmtr, 2);
  switch (assumptions(thm)) {
  | [] => ()
  | [f, ...fs] =>
    pp_print_formula(fmtr, f);
    fs
    |> List.iter(f => {
         pp_print_string(fmtr, ",");
         pp_print_space(fmtr, ());
         pp_print_formula(fmtr, f);
       });
    pp_print_space(fmtr, ());
  };
  pp_open_hbox(fmtr, ());
  pp_print_string(fmtr, "⊢");
  pp_print_space(fmtr, ());
  pp_print_formula(fmtr, consequence(thm));
  pp_close_box(fmtr, ());
  pp_close_box(fmtr, ());
};

// let by_assumption = (f: formula) => Ax(leaf(assumptions: [f], consequences: f ));

// let imp_i = (f, thm) =>
//   /* TODO: not implemented */
//   failwith ("not implemented")

// let imp_e =(th1, th2) =>
//   /* TODO: not implemented */
//   failwith ("not implemented")

// let bot_e = (f, thm )=>
//   /* TODO: not implemented */
//   failwith ("not implemented")
