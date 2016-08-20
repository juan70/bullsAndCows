(** NUmber of digits by default for the secret code *)
let num_digits = 4


(** Generate a random secret code *)
let secret_code () =
  let _ = Random.self_init () in
  (* Add a digit that is not already present in the list *)
  let rec add_new_digit ls =
  let d = Random.int 10 in
  if List.mem d ls then add_new_digit ls
                   else d :: ls
  in
  (* Generate a list of random digits *)
  let rec gen_rec i ns =
    if i <= 0 then ns
              else gen_rec (i - 1) (add_new_digit ns)
  in
  gen_rec num_digits []
  |> List.map string_of_int
  |> List.fold_left (^) ""


(** Convert a string into a list of characters *)
let rec to_list s =
  let rec to_list_rec i ls =
    if i < 0 then ls
             else to_list_rec (i - 1) (s.[i] :: ls)
  in
  to_list_rec (String.length s - 1) []


(** Compute the number of bulls *)
let get_bulls secret guess =
  List.fold_left2 (fun acc s g -> acc + if g = s then 1 else 0)
                  0 (to_list secret) (to_list guess)


(** Compute the number of cows *)
let get_cows secret guess =
  let lsecr = to_list secret
  and lgues = to_list guess in
  List.fold_left2 (fun acc s g -> acc + if g <> s
                                        && List.mem g lsecr
                                        then 1 else 0)
                  0 lsecr lgues

