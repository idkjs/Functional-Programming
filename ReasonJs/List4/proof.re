open Logic;

type proof; /* = TODO: enter your definition here */

let proof = (g, f) =>
  /* TODO: implement */
  failwith("not implemented");

let qed = pf =>
  /* TODO: implement */
  failwith("not implemented");

let goal = pf =>
  /* TODO: implement */
  failwith("not implemented");

let next = pf =>
  /* TODO: implement */
  failwith("not implemented");

let intro = (name, pf) =>
  /* TODO: implement */
  failwith("not implemented");

let apply = (f, pf) =>
  /* TODO: implement */
  failwith("not implemented");

let apply_thm = (thm, pf) =>
  /* TODO: implement */
  failwith("not implemented");

let apply_assm = (name, pf) =>
  /* TODO: implement */
  failwith("not implemented");

let pp_print_proof = (fmtr, pf) =>
  switch (goal(pf)) {
  | None => Format.pp_print_string(fmtr, "No more subgoals")
  | Some((g, f)) =>
    Format.pp_open_vbox(fmtr, -100);
    g
    |> List.iter(((name, f)) => {
         Format.pp_print_cut(fmtr, ());
         Format.pp_open_hbox(fmtr, ());
         Format.pp_print_string(fmtr, name);
         Format.pp_print_string(fmtr, ":");
         Format.pp_print_space(fmtr, ());
         pp_print_formula(fmtr, f);
         Format.pp_close_box(fmtr, ());
       });
    Format.pp_print_cut(fmtr, ());
    Format.pp_print_string(fmtr, String.make(40, '='));
    Format.pp_print_cut(fmtr, ());
    pp_print_formula(fmtr, f);
    Format.pp_close_box(fmtr, ());
  };
