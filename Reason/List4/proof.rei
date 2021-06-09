open Logic;

type proof;

/** Tworzy pusty dowód podanego twierdzenia */

let proof: (list((string, formula)), formula) => proof;

/** Zamienia ukończony dowód na twierdzenie */

let qed: proof => theorem;

/** Zwraca jeśli dowód jest ukończony, zwraca None. W przeciwnym wypadku
  zwraca Some(assm, phi), gdzie assm oraz phi to odpowiednio dostępne
  założenia oraz formuła do udowodnienia w aktywnym podcelu */

let goal: proof => option((list((string, formula)), formula));

/** Przesuwa cylkicznie aktywny podcel na następny (od lewej do prawej) */

let next: proof => proof;

/** Wywołanie intro name pf odpowiada regule wprowadzania implikacji.
  To znaczy aktywna dziura wypełniana jest regułą:

  (nowy aktywny cel)
   (name,ψ) :: Γ ⊢ φ
   -----------------(→I)
       Γ ⊢ ψ → φ

  Jeśli aktywny cel nie jest implikacją, wywołanie kończy się błędem */

let intro: (string, proof) => proof;

/** Wywołanie apply ψ₀ pf odpowiada jednocześnie eliminacji implikacji
  i eliminacji fałszu. Tzn. jeśli do udowodnienia jest φ, a ψ₀ jest
  postaci ψ₁ → ... → ψn → φ to aktywna dziura wypełniana jest regułami

  (nowy aktywny cel) (nowy cel)
        Γ ⊢ ψ₀          Γ ⊢ ψ₁
        ----------------------(→E)  (nowy cel)
                ...                   Γ ⊢ ψn
                ----------------------------(→E)
                            Γ ⊢ φ

  Natomiast jeśli ψ₀ jest postaci ψ₁ → ... → ψn → ⊥ to aktywna dziura
  wypełniana jest regułami

  (nowy aktywny cel) (nowy cel)
        Γ ⊢ ψ₀          Γ ⊢ ψ₁
        ----------------------(→E)  (nowy cel)
                ...                   Γ ⊢ ψn
                ----------------------------(→E)
                            Γ ⊢ ⊥
                            -----(⊥E)
                            Γ ⊢ φ */

let apply: (formula, proof) => proof;

/** Wywołanie apply_thm thm pf
 działa podobnie do apply (Logic.consequence thm) pf, tyle że
 aktywna dziura od razu jest wypełniana dowodem thm.
 Nowa aktywna dziura jest pierwszą na prawo po tej, która została
 wypełniona przez thm */;

let apply_thm: (theorem, proof) => proof;

/** Wywołanie apply_assm name pf
  działa tak jak apply (Logic.by_assumption f) pf,
  gdzie f jest załorzeniem o nazwie name */

let apply_assm: (string, proof) => proof;

let pp_print_proof: (Format.formatter, proof) => unit;
