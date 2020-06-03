Require Import List.
Import ListNotations.

Print list.
(*

  Inductive list (A : Type) : Type :=
  | nil : list A
  | cons : A -> list A -> list A

*)

Check (cons 1 (cons 2 (cons 3 nil))).
Definition list1 := [1;2;3].
Definition list2 := [4;5;6].

Print list1.

Fixpoint append {A : Type} (l l' : list A) : list A :=
  match l with
  | nil => l'
  | cons x xs => cons x (append xs l')
  end.

Compute append list1 list2.
Compute list1 ++ list2.

Fixpoint reverse {A : Type} (xs : list A) :=
  match xs with
  | nil => nil
  | x :: xs' => reverse xs' ++ [x]
  end.

Compute reverse list1.

Lemma reverse_append : forall (A : Type) (xs ys : list A),
  reverse (xs ++ ys) = reverse ys ++ reverse xs.
Proof.
  intros A xs ys.
  induction xs.
  - simpl.
    rewrite app_nil_r.
    reflexivity.
  - simpl.
    rewrite IHxs.
    rewrite app_assoc_reverse.
    reflexivity.
Qed.

Theorem reverse_reverse : forall (A : Type) (xs : list A),
  reverse (reverse xs) = xs.
Proof.
  intros A xs.
  induction xs.
  - simpl.
    reflexivity.
  - simpl.
    rewrite reverse_append.
    rewrite IHxs.
    simpl.
    reflexivity.
Qed.

(*
  https://coq.inria.fr/refman/addendum/extraction.html

  > The functional languages available as output are currently
    OCaml, Haskell and Scheme.
*)

Require Extraction.

Extraction Language OCaml.
Extraction "reverse.ml" reverse.

Extraction Language Haskell.
Extraction "reverse.hs" reverse.

Extraction Language Scheme.
Extraction "reverse.scm" reverse.

(* OCaml 組み込みのリストを使うには *)
Extraction Language OCaml.
Extract Inductive list => "list" ["[]" "(::)"].
Extraction "reverse2.ml" reverse.

