open Core
open Datatypes

let ansi_color code fmt =
  printf ("\x1b[" ^ code ^ "m" ^ fmt ^ "\x1b[0m")

let red fmt = ansi_color "31" fmt
let green fmt = ansi_color "32" fmt
let yellow fmt = ansi_color "33" fmt
let blue fmt = ansi_color "34" fmt
let magenta fmt = ansi_color "35" fmt
let cyan fmt = ansi_color "36" fmt
let white fmt = ansi_color "37" fmt

let display_transaction t = 
  cyan "%s: " (CalendarLib.Printer.Date.to_string t.date);
  green "%.2f " t.amount;
  yellow "(%s) - " (match t.category with
    | Food -> "Food"
    | Entertainment -> "Entertainment"
    | Investment -> "Investment"
    | Misc -> "Misc"
  );
  white "%s\n" t.description

let view_transactions transactions =
  if List.is_empty !transactions then 
    magenta "No transactions recorded\n"
  else 
    List.iter !transactions ~f:display_transaction

let add_transaction_cli transactions =
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
  Input.add_transaction date amount desc cat transactions;
  green "Transaction added!\n"

let rec cli_loop transactions =
  white "OCaml Finance Tracker:\n";
  white "  - [a]dd transactions\n";
  white "  - [v]iew transactions\n";
  white "  - [s]ave transactions\n";
  white "  - [l]oad transactions\n";
  white "  - [q]uit\n";
  match String.lowercase (read_line ()) with
  | "a" -> add_transaction_cli transactions; cli_loop transactions
  | "v" -> view_transactions transactions; cli_loop transactions
  | "s" -> blue "Enter filename to save: "; let filename = read_line () in SaveLoad.save_transactions filename transactions; cli_loop transactions
  | "l" -> blue "Enter filename to load: "; let filename = read_line () in SaveLoad.load_transactions filename transactions; cli_loop transactions
  | "q" -> red "Goodbye!  :)\n"
  |  _  -> red "Unknown command. You may try again.\n"; cli_loop transactions

let main () =
  let transactions = ref [] in
  cli_loop transactions

let () = main ()