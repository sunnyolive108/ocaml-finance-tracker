open Core

type category =
  | Food | Entertainment | Investment | Misc
  [@@deriving yojson]

type transaction = {
  date : CalendarLib.Date.t;
  amount : float;
  category : category;
  description : string;
} [@@deriving yojson]