type formula =
  | False
  | Var(string)
  | Impl(formula, formula);

let pp_print_formula: (Format.formatter, formula) => unit;

/** reprezentacja twierdzeń */

type theorem;

/** założenia twierdzenia */
/** teza twierdzeni */

let assumptions: theorem => list(formula);

/** teza twierdzeni */

let consequence: theorem => formula;

let pp_print_theorem: (Format.formatter, theorem) => unit;

/** by_assumption f konstuuje następujący dowód

  -------(Ax)
  {f} ⊢ f  */

let by_assumption: formula => theorem;

/** imp_i f thm konstuuje następujący dowód

       thm
      Γ ⊢ φ
 ---------------(→I)
 Γ \ {f} ⊢ f → φ */

let imp_i: (formula, theorem) => theorem;

/** imp_e thm1 thm2 konstuuje następujący dowód

    thm1      thm2
 Γ ⊢ φ → ψ    Δ ⊢ φ
 ------------------(→E)
 Γ ∪ Δ ⊢ ψ */

let imp_e: (theorem, theorem) => theorem;

/** bot_e f thm konstruuje następujący dowód

   thm
  Γ ⊢ ⊥
  -----(⊥E)
  Γ ⊢ f */

let bot_e: (formula, theorem) => theorem;
