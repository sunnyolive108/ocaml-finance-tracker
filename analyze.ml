open Datatypes

let total_spending_by_category cat transactions =
  List.fold !transactions ~init:0.0 ~f:(fun acc t ->
    if t.category = cat then acc +. t.amount else acc)

let monthly_spending transactions =
  List.fold !transactions ~init:(Map.empty (module Int)) ~f:(fun acc t ->
    let month = CalendarLib.Date.month t.date in
    Map.update acc month ~f:(function
      | None -> t.amount
      | Some v -> v +. t.amount))