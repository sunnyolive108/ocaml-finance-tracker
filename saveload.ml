open Datatypes

let save_transactions filename transactions = 
  let json = !transactions |> [%to_yojson: transaction list] in 
  Out_channel.write_all filename ~data:(Yojson.Safe.pretty_to_string json)

let load_transactions filename transactions =
  try
    let json = Yojson.Safe.from_file filename in
    transactions := json |> [%of_yojson: transaction list] |> Result.ok_or_failwith
  with _ -> printf "Error loading transactions\n"