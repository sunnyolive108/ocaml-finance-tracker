open Input
open Analyze

let save_transactions filename = 
  let json = !transactions |> [%to_yojson: transaction list] in 
  Out_channel.write_all filename ~data:(Yojson.Basic.pretty_to_string json)

 let load_transactions filename =
   try
     let json = Yojson.Basic.from_file filename in
     transactions := json |> [%of_yojson: transaction list] |> Result.ok_or_failwith
   with _ -> printf "Error loading transactions\n"
