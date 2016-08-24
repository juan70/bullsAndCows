open Str


(** The keyword used to leave the game. *)
let kw_quit = "quit"


(** An bit of information before starting. *)
let banner =
  "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    ^ "\n"
    ^ "Bulls and Cows: Guess the " ^ (string_of_int BullsCows.num_digits) ^ "-digits number"
    ^ "\n"
    ^ "Type \"" ^ kw_quit ^ "\" at any moment to leave the game."
    ^ "\n"
    ^ "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"


(** Return then number of bulls and cows found. *)
let compute_bulls_cows secret guess =
  (BullsCows.get_bulls secret guess, BullsCows.get_cows secret guess)


(** Basic beautifier for plural words.
 * "1 thing"
 * "2 things"
 * and "0 things" too. *)
let pluralize n =
  if n = 1 then "" else "s"


(** Compose a simply formatted report for bulls and cows. *)
let report bc =
  let (bulls, cows) = bc in
  Printf.sprintf "> %d bull%s, %d cow%s\n"
                 bulls (pluralize bulls) cows (pluralize cows)


(** Some say it's cheating, some say it's a hint... *)
let cheat secret =
  Random.self_init ();
  let lg = String.length secret in
  let idx = Random.int(lg) in
  let dig = String.init lg (fun i -> if i = idx then secret.[i] else '.')
  in
  print_endline (">>> Cheating? I give you only one digit randomly chosen: " ^ dig)


(** The main function. *)
let () =
  print_endline banner;
  let code = BullsCows.secret_code () in
  let rec main_loop tries cheated =
    Printf.printf "%d. Enter a %d-digits number: " tries BullsCows.num_digits;
    let inp = read_line () in
      match inp with
      | s when String.lowercase_ascii s = kw_quit ->
          ()
      | s when String.lowercase_ascii s = "cheat" ->
          cheat code;
          main_loop (tries + 1) true
      | s when String.length s <> BullsCows.num_digits ->
          Printf.printf "Error: %d digits are required. Try again.\n" BullsCows.num_digits;
          main_loop (tries + 1) cheated
      | s when Str.string_match (Str.regexp "[^0-9]") s 0 -> 
          print_endline "Error: Only digits allowed. Try again.";
          main_loop (tries + 1) cheated
      | _ ->
          let bc = compute_bulls_cows code inp
          in
          print_endline (report bc);
          match bc with
          | bulls, _ when bulls = BullsCows.num_digits ->
              Printf.printf "Congratulations!!!! You found the code %s.\n" code;
              if cheated then print_endline ("But you cheated, didn't you?"
                                           ^ " Yeah, you did, I know you did!!!!\n")
                         else print_newline ()
          |_ -> main_loop (tries + 1) cheated
  in
  main_loop 1 false

