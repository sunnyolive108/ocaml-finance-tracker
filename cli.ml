open Core

(* color definitions *)
let ansi_color code fmt =
  printf ("\xlb[" ^ code ^ "m" ^ fmt ^ "\xlb[0m")

let red fmt = ansi_color "31" fmt
let green fmt = ansi_color "32" fmt
let yellow fmt = ansi_color "33" fmt
let blue fmt = ansi_color "34" fmt
let magenta fmt = ansi_color "35" fmt
let cyan fmt = ansi_color "36" fmt
let white fmt = ansi_color "37" fmt

type category = 
  | Food | Entertainment | Investment | Misc

type transaction = {
  date : CalendarLib.Date.t;
  amount : float;
  description : string;
  category : category;
}

let transactions = ref []

let add_transaction date amount desc cat =
  let new_txn = { date; amount; description = desc; category = cat } in
  transactions := new_txn :: !transactions

let display_transaction t = 
  cyan "%s: " (CalendarLib.Printer.Date.to_string t.date);
  green "%.2f " t.amount;
  yellow "(%s) - " (match t.category with
    | Food -> "Food"
    | Entertainment -> "Entertainment"
    | Investment -> "Investment"
    | Misc -> "Misc"
);
white "%s\n" t.destination

let view_transactions () =
  if List.is_empty !transactions then 
    magenta "No transactions recorded\n"
  else 
    List.iter !transactions ~f:display_transaction

let add_transaction_cli () =
  blue "Enter date (YYYY-MM-DD): ";
  let date = CalendarLib.Printer.Date.from_string (read_line ()) in
  blue "Enter amount: ";
  let amount = float_of_string (read_line()) in
  blue "Enter description: ";
  let desc = read_line () in
  blue "Enter category [Food | Ent | Inv | Misc]: ";
  let cat = match read_line () with
    | "Food" -> Food | "Ent" -> Entertainment 
    | "Inv" -> Investment | _ -> Misc in
  add_transaction date amount desc cat;
  green "Transaction added!\n"

let rec cli_loop () =
  white "OCaml Finance Tracker:\n";
  white "  - [a]dd transactions\n";
  white "  - [v]iew transactions\n";
  white "  - [q]uit\n";
  match String.lowercase (read_line ()) with
  | "a" -> add_transaction_cli (); cli_loop ()
  | "v" -> view_transactions (); cli_loop ()
  | "q" -> red "Goodbye!  :)\n"
  |  _  -> red "Unknown command. You may try again.\n"; cli_loop ()

let () =
  cli_loop ()

