Theorem backward_small : (forall A B : Prop, A -> (A->B)->B).
Proof.
  intros A B.
  intros proof_of_A A_implies_B.
  refine (A_implies_B _).
  exact proof_of_A.
Qed.
