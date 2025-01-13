open Datatypes  

let add_transaction date amount desc cat transactions =
  let new_txn = { date; amount; category = cat; description = desc } in
  transactions := new_txn :: !transactions
