type formula =
  | False
  | Var(string)
  | Impl(formula, formula);

let pp_print_formula: (Format.formatter, formula) => unit;

/* * statement representation */
type theorem;

/* * assumptions of the theorem */
let assumptions: theorem => list(formula);
/* * thesis */
let consequence: theorem => formula;

let pp_print_theorem: (Format.formatter, theorem) => unit;

/* * by_assumption f constructs the following proof
     -------(Ax)
     {f} ⊢ f */
let by_assumption: formula => theorem;

/* * imp_i f thm constructs the following proof
      thm
      Γ ⊢ φ
      ---------------(→I)
     Γ \ {f} ⊢ f → φ */
let imp_i: (formula, theorem) => theorem;

/* * imp_e thm1 thm2 makes the following proof
      thm1 thm2
      Γ ⊢ φ → ψ Δ ⊢ φ
      ------------------(→E)
     Γ ∪ Δ ⊢ ψ */
let imp_e: (theorem, theorem) => theorem;

/* * bot_e f thm constructs the following proof
      thm
      Γ ⊢ ⊥
      -----(⊥E)
     Γ ⊢ f */
let bot_e: (formula, theorem) => theorem;
