open Datatypes

let add_transaction date amount desc cat =
  let new_txn = { date; amount; description = desc; category = cat } in
  transactions := new_txn :: !transactions

