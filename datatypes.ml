open Core

type category =
  | Food | Entertainment | Investment | Misc
  [@@deriving yojson]

type transaction = {
  date : CalenderLib.Date.t;
  amount : float;
  description : category
} [@@deriving yojson]

let transaction = ref []

