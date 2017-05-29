Theorem false : ~False.
Proof.
  unfold not.
  intros proof_of_False.
  exact proof_of_False.
Qed.
