open Vlang
open Lang
open Query
open Options
open Yojson.Basic

let iter = ref 0

module QMap = struct
  module BatMap = BatMap.Make (struct type t = Query.src let compare = Query.compare_src end)

  type t = v BatMap.t
  and k = Query.src
  and v = status * fkey BatSet.t * iter
  and iter = int
          
  let mk_key = Query.get_src
  
  let add = BatMap.add
  let find = BatMap.find
  let empty = BatMap.empty
  let bindings = BatMap.bindings
  let for_all = BatMap.for_all
  let map = BatMap.mapi
end

let get_proven : (QMap.k * QMap.v) list -> (QMap.k * QMap.v) list
= fun lst -> List.filter (fun (_,(stat,_,_)) -> stat = Proven) lst

let get_unproven : (QMap.k * QMap.v) list -> (QMap.k * QMap.v) list
= fun lst -> List.filter (fun (_,(stat,_,_)) -> stat = UnProven) lst

let filter ~kind:k lst =
  List.filter (fun ((k',_,_),_) -> k=k') lst

let print : QMap.t -> unit
= fun qmap ->
  let lst = QMap.bindings qmap in
  let unproven_lst = get_unproven lst in
  (* let proven_lst = get_proven lst in *)
  print_endline "=== Report ===";
  List.iteri (fun i ((k,l,s) as src, (stat,fkey,iter)) ->
    let s1 = "[" ^ string_of_int (i+1) ^ "]" ^ " " ^ "[" ^ Query.to_string_kind_simple k ^ "]" ^ " " in
    let s2 = Query.to_string_src src ^ " : " ^ to_string_status stat in
    print_endline (s1 ^ s2);
  ) lst;
  print_endline "";
  print_endline "=== Statistics ===";
  print_endline ("# Iter                    : " ^ string_of_int !iter);
  print_endline ("# Alarm / Query           : " ^ string_of_int (List.length unproven_lst) ^ " / " ^ string_of_int (List.length lst));
  if !check_io      then print_endline ("- integer over/underflow  : " ^ string_of_int (List.length (filter ~kind:IO unproven_lst)) ^ " / " ^ string_of_int (List.length (filter ~kind:IO lst)));
  if !check_dz      then print_endline ("- division-by-zero        : " ^ string_of_int (List.length (filter ~kind:DZ unproven_lst)) ^ " / " ^ string_of_int (List.length (filter ~kind:DZ lst)));
  if !check_assert  then print_endline ("- assertion violation     : " ^ string_of_int (List.length (filter ~kind:ASSERT unproven_lst)) ^ " / " ^ string_of_int (List.length (filter ~kind:ASSERT lst)))

let proved_nontrivially : (QMap.k * QMap.v) list -> int
= fun lst ->
  let lst' = List.filter (fun (_,(stat,_,i)) -> stat = Proven && i > 1) lst in
  List.length lst'

let json : QMap.t -> unit
= fun qmap ->
  let lst = QMap.bindings qmap in
  let results =
    List.mapi (fun i ((kind,loc,str),(stat,fkeys,iter)) ->
      `Assoc [("no", `String (string_of_int (i+1)));
              ("kind", `String (to_string_kind_simple kind));
              ("line", `String (string_of_int loc));
              ("signatures", `List (fkeys
                                    |> BatSet.to_list
                                    |> List.map (fun (cname,fname,typs) ->
                                        `Assoc [("contractName", `String cname);
                                                ("methodName", `String fname);
                                                ("argTypes", `List (typs |> List.map (fun t -> `String (to_string_typ t))))])));
              ("exp", `String str);
              ("status", `String (to_string_status stat))]
    ) lst
  in
  let j =
    `Assoc [("fileName", `String !inputfile);
            ("baseName", `String (Filename.basename !inputfile));
            ("iter", `Int !iter);
            ("time", `String (string_of_float !Profiler.end_cpu));
            ("errMsg", `Null);
            ("result", `List results)] in
  let base = snd (BatString.replace (Filename.basename !inputfile) ".sol" "") in
  let full_fname =
    if !Options.outdir = "" then "./output/" ^ base ^ ".json"
    else !Options.outdir ^ "/" ^ base ^ ".json" in
  let fp = open_out full_fname in
  Printf.fprintf fp "%s" (Yojson.Basic.pretty_to_string j);
  close_out fp
