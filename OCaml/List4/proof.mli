open  Logic

type  proof

(* * Creates an empty proof of the given theorem *)
val  proof : ( string  *  formula ) list -> formula -> proof

(* * Turns the completed proof into a statement *)
val  qed : proof -> theorem

(* * Returns if the proof is complete, returns None, otherwise
 returns Some (assm, phi), where assm and phi are respectively available
assumptions and formula to be proven in the active sub-target *)
val  goal : proof -> (( string  *  formula ) list  *  formula ) option

(* * Moves the active sub-target to the next one (from left to right) *)
val  next : proof -> proof

(* * The call to intro name pf corresponds to the rule for introducing implications.
 That is, the active hole is filled with the rule:
 (new active target)
 (name, ψ) :: Γ ⊢ φ
 ----------------- (→ I)
 Γ ⊢ ψ → φ
If the active target is not an implication, the invocation fails with an error *)
val  intro : string -> proof -> proof

(* * The call to apply ψ₀ pf also corresponds to the elimination of the implication
and the elimination of falsehood. Ie. if there is φ to prove, and ψ₀ is
 of the form ψ₁ → ... → ψn → φ then the active hole is filled with rules

 (new active target) (new target)
 Γ ⊢ ψ₀ Γ ⊢ ψ₁
 ---------------------- (→ E) (new target)
 ... Γ ⊢ ψn
 ---------------------------- (→ E)
 Γ ⊢ φ
 Conversely, if ψ₀ is of the form ψ₁ → ... → ψn → ⊥ then an active hole
 is filled with rules
 (new active target) (new target)
 Γ ⊢ ψ₀ Γ ⊢ ψ₁
 ---------------------- (→ E) (new target)
 ... Γ ⊢ ψn
 ---------------------------- (→ E)
 Γ ⊢ ⊥
 ----- (⊥E)
Γ ⊢ φ *)
val  apply : formula -> proof -> proof

(* * Call apply_thm thm pf
 works similar to apply (Logic.consequence thm) pf, except that
 the active hole is immediately filled with the thm proof.
 The new active hole is the first to the right after the one left
filled by thm *)

val  apply_thm : theorem -> proof -> proof

(* * Call apply_assm name pf
 works like apply (Logic.by_assumption f) pf,
where f is an assumption named name *)
val  apply_assm : string -> proof -> proof

val  pp_print_proof : Format .formatter -> proof -> unit
