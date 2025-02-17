namespace Example

inductive List (α : Type u) where
  | nil : List α
  | cons (head : α) (tail : List α) : List α

namespace List

def foldr (f : α → β → β) (init : β) : List α → β
  | .nil => init
  | .cons a l => f a (foldr f init l)

-- Partial is just so I don't have to do a recursion proof, it actually inhibits opts
-- in certain special cases
partial def range (final : UInt64) (xs : List UInt64 := nil) : List UInt64 :=
  if final == 0 then
    xs
  else
    let m := final - 1
    range m (cons m xs)

end List
end Example

def main (xs : List String) : IO Unit := do
  let n := UInt64.ofNat $ String.toNat! xs.head!
  let size := 1000000 * n
  let list := Example.List.range size .nil
  IO.print $ list.foldr (· + ·) 0
