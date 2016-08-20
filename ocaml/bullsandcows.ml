open Str


let kw_quit = "quit"


let banner =
  "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    ^ "\n"
    ^ "Bulls and Cows: Guess the " ^ (string_of_int BullsCows.num_digits) ^ "-digits number"
    ^ "\n"
    ^ "Type \"" ^ kw_quit ^ "\" at any moment to leave the game."
    ^ "\n"
    ^ "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"


let compute_bulls_cows secret guess =
  (BullsCows.get_bulls secret guess, BullsCows.get_cows secret guess)


let pluralize n =
  if n = 1 then "" else "s"


let cheat secret =
  Random.self_init ();
  let lg = String.length secret in
  let idx = Random.int(lg) in
  let dig = String.init lg (fun i -> if i = idx then secret.[i] else '.')
  in
  print_endline (">>> Cheating? I give you only one digit randomly chosen: " ^ dig)


let () =
  print_endline banner;
  let code = BullsCows.secret_code () in
  let rec main_loop tries cheated =
    Printf.printf "%d. Enter a %d-digits number: " (tries + 1) BullsCows.num_digits;
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
        let bc = compute_bulls_cows code inp in
        let bulls = fst bc
        and cows = snd bc
        in
        Printf.printf "%d bull%s, %d cow%s\n\n"
                      bulls (pluralize bulls) cows (pluralize cows);
        if bulls = BullsCows.num_digits
        then (Printf.printf "Congratulations!!!! You found the code %s.\n" code;
              if cheated then print_endline ("But you cheated, didn't you?"
                                          ^ " Yeah, you did, I know you did!!!!\n")
                         else print_newline ())
        else main_loop (tries + 1) cheated
  in
  main_loop 0 false

