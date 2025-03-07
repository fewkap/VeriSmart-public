open Vlang
open Semantics
open Lang
open Simplification
open Tactic

let template0 : vformula -> bool
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst_6 = pre |> list_of_conjuncts |> cartesian_6 in
  List.exists (fun l ->
    match l,con with
    | [NoOverFlow (b_1,_);
       SigmaEqual ((b_2,_), VVar (total1,_));
       VBinRel (VGeq, VInt n, VVar (total2,_));
       VBinRel (VGeq, Read (VVar (b_3,_), x1, _), v1);
       VBinRel (VEq, VVar (b__1,_), Write (VVar (b_4,_), x2, VBinOp (VSub, Read (VVar (b_5,_), x3,_), v2, _)));
       VBinRel (VEq, VVar (b1,_), Write (VVar (b__2,_), y1, VBinOp (VAdd, Read (VVar (b__3,_), y2,_), v3, _)))
      ],
      VBinRel (VGeq, VBinOp (VAdd, Read (VVar (b2,_), x4,_), Read (VVar (b3,_), y3,_), _),
                                   Read (VVar (b4,_), x5,_))
      when BatBig_int.lt_big_int (BatBig_int.add n n) max_256bit &&
           total1 = total2 &&
           b_1 = b_2 && b_2 = b_3 && b_3 = b_4 && b_4 = b_5 &&
           b__1 = b__2 && b__2 = b__3 &&
           b1=b2 && b2=b3 && b3=b4 &&
           equal_ve x1 x2 && equal_ve x2 x3 && equal_ve x3 x4 && equal_ve x4 x5 &&
           equal_ve y1 y2 && equal_ve y2 y3 &&
           equal_ve v1 v2 && equal_ve v2 v3
      -> true
    | [NoOverFlow (b_1,_);
       SigmaEqual ((b_2,_), VVar (total1,_));
       VBinRel (VEq,VVar (total2,_), VInt n); (* the only difference. *)
       VBinRel (VGeq, Read (VVar (b_3,_), x1, _), v1);
       VBinRel (VEq, VVar (b__1,_), Write (VVar (b_4,_), x2, VBinOp (VSub, Read (VVar (b_5,_), x3,_), v2, _)));
       VBinRel (VEq, VVar (b1,_), Write (VVar (b__2,_), y1, VBinOp (VAdd, Read (VVar (b__3,_), y2,_), v3, _)))
      ],
      VBinRel (VGeq, VBinOp (VAdd, Read (VVar (b2,_), x4,_), Read (VVar (b3,_), y3,_), _),
                                   Read (VVar (b4,_), x5,_))
      when BatBig_int.lt_big_int (BatBig_int.add n n) max_256bit &&
           total1 = total2 &&
           b_1 = b_2 && b_2 = b_3 && b_3 = b_4 && b_4 = b_5 &&
           b__1 = b__2 && b__2 = b__3 &&
           b1=b2 && b2=b3 && b3=b4 &&
           equal_ve x1 x2 && equal_ve x2 x3 && equal_ve x3 x4 && equal_ve x4 x5 &&
           equal_ve y1 y2 && equal_ve y2 y3 &&
           equal_ve v1 v2 && equal_ve v2 v3
      -> true
    | _ -> false
  ) lst_6

let template1 : vformula -> bool
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst_5 = pre |> list_of_conjuncts |> cartesian_5 in
  List.exists (fun l ->
    match l,con with
    | [NoOverFlow (b_1,_);
       SigmaEqual ((b_2,_), VVar (total1,_));
       VBinRel (VEq, VVar (total2,_), VInt n);
       VBinRel (VGeq, Read (VVar (b_3,_), x1, _), v1);
       VBinRel (VEq, VVar (b1,_), Write (VVar (b_4,_), y1, VBinOp (VAdd, Read (VVar (b_5,_), y2,_), v2, _)))
      ],
      VBinRel (VGeq, Read (VVar (b2,_), x2,_), v3)
      when is_renamed b_1 && is_renamed b_2 && is_renamed b_3 && is_renamed b_4 && is_renamed b_5 &&
           not (is_renamed b1) && not (is_renamed b2) &&
           BatBig_int.lt_big_int (BatBig_int.add n n) max_256bit &&
           BatString.equal b_1 b_2 && BatString.equal b_2 b_3 && BatString.equal b_3 b_4 && BatString.equal b_4 b_5 &&
           BatString.equal b1 b2 &&
           BatString.equal total1 total2 &&
           equal_ve x1 x2 &&
           equal_ve y1 y2 &&
           equal_ve v1 v2 && equal_ve v2 v3
      -> true
      (* Similar to template 4. *)
    | [NoOverFlow (b_1,_);
       VBinRel (VGeq, Read (VVar (b_2,_), x1, _), v1);
       VBinRel (VEq, VVar (b1,_), Write (VVar (b_3,_), x2, VBinOp (VSub, Read (VVar (b_4,_), x3,_), v2, _)));
       VBinRel (VEq, p1, Read (VVar (b2,_), y,_));
       VBinRel (VEq, q1, v3)
      ],
      VBinRel (VGeq, VBinOp (VAdd, p2, q2, _), p3)
      when is_renamed b_1 && is_renamed b_2 && is_renamed b_3 && is_renamed b_4 &&
           not (is_renamed b1) && not (is_renamed b2) &&
           BatString.equal b_1 b_2 && BatString.equal b_2 b_3 && BatString.equal b_3 b_4 &&
           BatString.equal b1 b2 &&
           equal_ve x1 x2 && equal_ve x2 x3 &&
           equal_ve v1 v2 && equal_ve v2 v3 &&
           equal_ve p1 p2 && equal_ve p2 p3 &&
           equal_ve q1 q2
      -> true
    | _ -> false
  ) lst_5

let template2 : vformula -> bool
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst_4 = pre |> list_of_conjuncts |> cartesian_4 in
  List.exists (fun l ->
    match l,con with
    | [NoOverFlow (b1,_);
       SigmaEqual ((b2,_), VVar (total1,_));
       VBinRel (VEq, VVar (total2,_), VInt n);
       VBinRel (VGeq, Read (VVar (b3,_), x, _), v1)
      ],
      VBinRel (VGeq, VBinOp (VAdd, Read (VVar (b4,_), y1,_), v2, _),
                     Read (VVar (b5,_), y2,_))
      when BatBig_int.lt_big_int (BatBig_int.add n n) max_256bit &&
           BatString.equal total1 total2 &&
           BatString.equal b1 b2 && BatString.equal b2 b3 && BatString.equal b3 b4 && BatString.equal b4 b5 &&
           equal_ve v1 v2 && equal_ve y1 y2
      -> true
    | [NoOverFlow (b1,_);
       SigmaEqual ((b2,_), VVar (total1,_));
       VBinRel (VGeq, VInt n, VVar (total2,_)); (* the only differnece compared to above one. *)
       VBinRel (VGeq, Read (VVar (b3,_), x, _), v1)
      ],
      VBinRel (VGeq, VBinOp (VAdd, Read (VVar (b4,_), y1,_), v2, _),
                     Read (VVar (b5,_), y2,_))
      when BatBig_int.lt_big_int (BatBig_int.add n n) max_256bit &&
           BatString.equal total1 total2 &&
           BatString.equal b1 b2 && BatString.equal b2 b3 && BatString.equal b3 b4 && BatString.equal b4 b5 &&
           equal_ve v1 v2 && equal_ve y1 y2
      -> true
    | _ -> false
  ) lst_4

let template3 : vformula -> bool 
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst_3 = pre |> list_of_conjuncts |> cartesian_3 in
  List.exists (fun l ->
    match l,con with
    | [NoOverFlow (b1,_);
       SigmaEqual ((b2,_), VInt n);
       VBinRel (VGeq, Read (VVar (b3,_), x, _), v1)
      ],
      VBinRel (VGeq, VBinOp (VAdd, Read (VVar (b4,_), y1,_), v2, _),
                                   Read (VVar (b5,_), y2,_))
      when BatBig_int.lt_big_int (BatBig_int.add n n) max_256bit &&
           BatString.equal b1 b2 && BatString.equal b2 b3 && BatString.equal b3 b4 && BatString.equal b4 b5 &&
           equal_ve v1 v2 && equal_ve y1 y2
      -> true
    | [NoOverFlow (b1,_);
       SigmaEqual ((b2,_), VVar (total1,_));
       VBinRel (VGeq, VInt n, VVar (total2,_));
      ],
      VBinRel (VGeq, VBinOp (VAdd, Read (VVar (b3,_), x1,_), Read (VVar (b4,_), y,_), _),
                                   Read (VVar (b5,_), x2,_))
      when BatBig_int.lt_big_int (BatBig_int.add n n) max_256bit &&
           total1=total2 &&
           b1=b2 && b2=b3 && b3=b4 && b4=b5 &&
           equal_ve x1 x2
      -> true
    | [NoOverFlow (b1,_);
       SigmaEqual ((b2,_), VVar (total1,_));
       VBinRel (VEq, VVar (total2,_), VInt n); (* the only difference *)
      ],
      VBinRel (VGeq, VBinOp (VAdd, Read (VVar (b3,_), x1,_), Read (VVar (b4,_), y,_), _),
                                   Read (VVar (b5,_), x2,_))
      when BatBig_int.lt_big_int (BatBig_int.add n n) max_256bit &&
           total1=total2 &&
           b1=b2 && b2=b3 && b3=b4 && b4=b5 &&
           equal_ve x1 x2
      -> true
    | _ -> false
  ) lst_3

(* NoOverFlow (b') /\ b'[x]>=v /\ b[x] = b'[x] - v
   ->
   b[y] + v >= b[y] *)

let template4 : vformula -> bool
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst_3 = pre |> list_of_conjuncts |> cartesian_3 in
  List.exists (fun l ->
    match l,con with
    | [NoOverFlow (b_1,_);
       VBinRel (VGeq, Read (VVar (b_2,_), x1, _), v1);
       VBinRel (VEq, VVar (b1,_), Write (VVar (b_3,_), x2, VBinOp (VSub, Read (VVar (b_4,_), x3,_), v2, _)))
      ],
      VBinRel (VGeq, VBinOp (VAdd, Read (VVar (b2,_), y1,_), v3, _),
                     Read (VVar (b3,_), y2,_))
      when is_renamed b_1 && is_renamed b_2 && is_renamed b_3 && is_renamed b_4 &&
           not (is_renamed b1) && not (is_renamed b2) && not (is_renamed b3) &&
           BatString.equal b_1 b_2 && BatString.equal b_2 b_3 && BatString.equal b_3 b_4 &&
           BatString.equal b1 b2 && BatString.equal b2 b3 &&
           equal_ve x1 x2 && equal_ve x2 x3 &&
           equal_ve y1 y2 &&
           equal_ve v1 v2 && equal_ve v2 v3
      -> true
    | _ -> false
  ) lst_3

(*  G' = _ /10 /\
 *  G' > B /\
 *  G  = B /\
 *  ->
 *  G * 10 is safe.
 * *)

let template5 : vformula -> bool
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst_3 = pre |> list_of_conjuncts |> cartesian_3 in
  List.exists (fun l ->
    match l,con with
    | [VBinRel (VEq, VVar (x_1,_), VBinOp (VDiv,_,divisor1,_));
       VBinRel (VGt, VVar (x_2,_), e1);
       VBinRel (VEq, VVar (x1,_), e2) 
      ],
      VOr (_, VAnd (VNot _, VBinRel (VEq, VBinOp (VDiv, VBinOp (VMul, VVar (x2,_), divisor2, _), VVar (x3,_), _), divisor3)))
      when is_renamed x_1 && is_renamed x_2 &&
           not (is_renamed x1)  && not (is_renamed x2) && not (is_renamed x3) &&
           BatString.equal x_1 x_2 &&
           BatString.equal x1 x2 && BatString.equal x2 x3 && 
           equal_ve divisor1 divisor2 && equal_ve divisor2 divisor3 &&
           equal_ve e1 e2
      -> true
    | _ -> false 
  ) lst_3

(*  b'[f] >= v /\
 *  b'[to] + v > b'[to] /\
 *  b'' = write (b', f, b'[f] - v) /\
 *  ->
 *  b''[to] + v >= b''[to]
 *  *)
let template6 : vformula -> bool
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst_3 = pre |> list_of_conjuncts |> cartesian_3 in
  List.exists (fun l ->
    match l,con with
    | [VBinRel (rel1, Read (VVar (b_1,_), f1, _), v1);
       VBinRel (rel2, VBinOp (VAdd, Read (VVar (b_2,_), t1, _), v2, _), Read (VVar (b_3,_), t2, _));
       VBinRel (VEq, VVar (b1,_), Write (VVar (b_4,_), f2, VBinOp (VSub, Read (VVar (b_5,_), f3,_), v3, _)))
      ],
      VBinRel (VGeq, VBinOp (VAdd, Read (VVar (b2,_), t3, _), v4, _),
                     Read (VVar (b3,_), t4,_))
      when BatString.equal b_1 b_2 && BatString.equal b_2 b_3 && BatString.equal b_3 b_4 && BatString.equal b_4 b_5 &&
           BatString.equal b1 b2 && BatString.equal b2 b3 &&
           not (BatString.equal b_1 b1) &&
           equal_ve f1 f2 && equal_ve f2 f3 &&
           equal_ve t1 t2 && equal_ve t2 t3 && equal_ve t3 t4 &&
           equal_ve v1 v2 && equal_ve v2 v3 && equal_ve v3 v4 &&
           (rel1 = VGeq || rel1 = VGt) && (rel2 = VGeq || rel2 = VGt)
      -> true
    | [VBinRel (VGeq, Read (VVar (b_1,_), VVar (f1,_), _), x1);
       VBinRel (VGt, VBinOp (VAdd, Read (VVar (b_2,_), VVar (t1,_), _), y1, _), Read (VVar (b_3,_), VVar (t2,_), _));
       VBinRel (VEq, VVar (b1,_), Write (VVar (b_4,_), VVar (f2,_), VBinOp (VSub, Read (VVar (b_5,_), VVar (f3,_),_), x2, _)))
      ],
      VBinRel (VGeq, VBinOp (VAdd, Read (VVar (b2,_), VVar (t3,_), _), y2, _),
                     Read (VVar (b3,_), VVar (t4,_),_))
      when is_renamed b_1 && is_renamed b_2 && is_renamed b_3 && is_renamed b_4 && is_renamed b_5 &&
           not (is_renamed b1) && not (is_renamed b2) && not (is_renamed b3) &&
           BatString.equal b_1 b_2 && BatString.equal b_2 b_3 && BatString.equal b_3 b_4 && BatString.equal b_4 b_5 && 
           BatString.equal b1 b2 && BatString.equal b2 b3 &&
           BatString.equal f1 f2 && BatString.equal f2 f3 &&
           BatString.equal t1 t2 && BatString.equal t2 t3 && BatString.equal t3 t4 &&
           equal_ve x1 x2 && equal_ve y1 y2
      -> true 
    | _ -> false
  ) lst_3

(*  g' = (100 * m) / p /\
 *  g' > e /\
 *  g = e /\
 *  v = (g * p) / 100
 *  ->
 *  m >= v is safe.
 * *)

let template7 : vformula -> bool
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst = list_of_conjuncts pre in
  let lst1 = List.filter (fun vf -> match vf with VBinRel (VEq, VVar _, VBinOp (VDiv, VBinOp (VMul, VInt _, VVar _, _), _, _)) -> true | _ -> false) lst in
  let lst2 = List.filter (fun vf -> match vf with VBinRel (VGt, VVar _, _) -> true | _ -> false) lst in
  let lst3 = List.filter (fun vf -> match vf with VBinRel (VEq, VVar _, _) -> true | _ -> false) lst in
  let lst4 = List.filter (fun vf -> match vf with VBinRel (VEq, VVar _, VBinOp (VDiv, VBinOp (VMul, _, _, _), VInt _, _)) -> true | _ -> false) lst in
  let lst = BatList.n_cartesian_product [lst1;lst2;lst3;lst4] in
  List.exists (fun l ->
    match l,con with
    | [VBinRel (VEq, VVar (x_1,_), VBinOp (VDiv, VBinOp (VMul, VInt n1, VVar (m1,_), _), p1, _));
       VBinRel (VGt, VVar (x_2,_), e1);
       VBinRel (VEq, VVar (x1,_), e2);
       VBinRel (VEq, VVar (y1,_), VBinOp (VDiv, VBinOp (VMul, VVar (x2,_), p2, _), VInt n2, _))
      ],
      VBinRel (VGeq, VVar (m2,_), VVar (y2,_))
      when is_renamed x_1 && is_renamed x_2 &&
           not (is_renamed x1) && not (is_renamed x2) &&
           BatBig_int.equal n1 n2 &&
           BatString.equal m1 m2 &&
           equal_ve p1 p2 &&
           equal_ve e1 e2 &&
           BatString.equal x1 x2 &&
           BatString.equal y1 y2
           -> true
    | [VBinRel (VEq, VVar (x_1,_), VBinOp (VDiv, VBinOp (VMul, VInt n1, VVar (m1,_), _), p1, _));
       VBinRel (VGt, VVar (x_2,_), e1);
       VBinRel (VEq, VVar (x1,_), e2);
       (* e3 instead of x2: necessary when eq propagation is performed *)
       VBinRel (VEq, VVar (y1,_), VBinOp (VDiv, VBinOp (VMul, e3, p2, _), VInt n2, _))
      ],
      VBinRel (VGeq, VVar (m2,_), VVar (y2,_))
      when is_renamed x_1 && is_renamed x_2 &&
           not (is_renamed x1) &&
           BatBig_int.equal n1 n2 &&
           BatString.equal m1 m2 &&
           equal_ve p1 p2 &&
           equal_ve e1 e2 && equal_ve e2 e3 &&
           BatString.equal y1 y2
           -> true
    | _ -> false
  ) lst

(* A = 1 -> A == 0 \/ (A!=0 /\ (A * B / A) ==B)
 * e1       e2         e3       e4     e6
 * i.e., if A=1, 'A*B' is safe. *)
let template8 : vformula -> bool
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst = list_of_conjuncts pre in
  List.exists (fun f ->
    match f,con with
    | VBinRel (VEq,e1,VInt n1),
      VOr (VBinRel (VEq,e2,VInt n2),
           VAnd (VNot (VBinRel (VEq,e3,VInt n3)), VBinRel (VEq, VBinOp (VDiv, (VBinOp (VMul,e4,e5,t)),e6,t'), e7))) ->
      BatBig_int.equal n1 BatBig_int.one && BatBig_int.equal n2 BatBig_int.zero && BatBig_int.equal n3 BatBig_int.zero &&
      equal_ve e1 e2 && equal_ve e2 e3 && equal_ve e3 e4 && equal_ve e4 e6
    | _ -> false
  ) lst

(* a=0 -> a+b>=a *)
let template9 : vformula -> bool
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst = list_of_conjuncts pre in
  List.exists (fun f ->
    match f,con with
    | VBinRel (VEq,e1,VInt n0), VBinRel (VGeq,VBinOp (VAdd,e2,e3,typ),e4)
      when equal_ve e2 e4 && BatBig_int.equal n0 BatBig_int.zero ->
      equal_ve e1 e2 || equal_ve e1 e3
    | _ -> false
  ) lst

(* e1>=e2 -> e1>=e2, e1>e2 -> e1>=e2 *)
let template10 : vformula -> bool
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst = list_of_conjuncts pre in
  List.exists (fun f ->
    match f,con with
    | VBinRel (brel,e1,e2), VBinRel (VGeq,e3,e4)
      when equal_ve e1 e3 && equal_ve e2 e4 && (brel=VGt || brel=VGeq)
      -> true
    | _ -> false
  ) lst

(* A = B / C /\ C != 0 -> A == 0 \/ (A != 0 /\ (A * C / A) == C)  *)
(* e1  e2  e3   e4  n4   e5   n5    e6   n6    e7  e8   e9   e10  *)
(* i.e., (B/C) * C is safe. *)

let template11 : vformula -> bool
= fun vf ->
  let (pre,con) = split_implication vf in
  let lst_2 = pre |> list_of_conjuncts |> cartesian_2 in
  List.exists (fun l ->
    match l,con with
    | [VBinRel (VEq,e1,VBinOp(VDiv,e2,e3,_));
       VNot (VBinRel (VEq,e4,VInt n4))],
      VOr (VBinRel (VEq,e5,VInt n5),
           VAnd (VNot (VBinRel (VEq,e6,VInt n6)), VBinRel (VEq, VBinOp (VDiv, (VBinOp (VMul,e7,e8,_)),e9,_),e10)))
      when BatBig_int.equal n4 BatBig_int.zero &&
           BatBig_int.equal n5 BatBig_int.zero &&
           BatBig_int.equal n6 BatBig_int.zero &&
           equal_ve e1 e5 && equal_ve e5 e6 && equal_ve e6 e7 && equal_ve e7 e9 &&
           equal_ve e3 e4 && equal_ve e4 e8 && equal_ve e8 e10
           -> true
    | _ -> false
  ) lst_2

let valid_template : vformula -> bool
= fun vf ->
  match vf with
  | VTrue -> true
  | Imply (VFalse,_) -> true
  | Imply (_,VTrue) -> true
  | Imply (_,VNot (VBinRel (VEq,VInt n1,VInt n2))) ->
    not (BatBig_int.equal n1 n2)
  | Imply (_,VBinRel (VGeq, (* e.g., v >= (v*99)/100 *)
                      VVar (v1,_),
                      VBinOp (VDiv, VBinOp (VMul, VVar (v2,_), VInt n1, _), VInt n2, _)))
    when BatString.equal v1 v2 && BatBig_int.lt_big_int n1 n2
    -> true
  | Imply (_,VBinRel (VGeq, (* e.g., (x%10) + 1 >= (x%10) *)
                      VBinOp (VAdd, VBinOp (VMod,_,VInt n1,_), VInt n2, t1),
                      VBinOp (VMod,_,VInt n3,t2)))
    when BatBig_int.ge_big_int (BatBig_int.add n1 n2) n3
         && BatBig_int.ge_big_int (BatBig_int.of_int 1000000000000000) (BatBig_int.add n1 n2)
         && is_uint256 t1 && is_uint256 t2
    -> true
  | Imply (_,VBinRel (VGeq, (* e.g., 48 + (x%10) >= 48 *)
                      VBinOp (VAdd, VInt n1, VBinOp (VMod,_,VInt n2,_), t),
                      VInt n3))
    when BatBig_int.ge_big_int (BatBig_int.add n1 n2) n3
         && BatBig_int.ge_big_int (BatBig_int.of_int 1000000000000000) (BatBig_int.add n1 n2)
         && is_uint256 t
    -> true
  | Imply (_,VBinRel (VGeq, (* e.g., 140 + uint8(exp/42) *)
                      VBinOp (VAdd, VInt n1, VCast (EType (UInt 8), VBinOp (VDiv,_,VInt n2,_)), _),
                      VInt n3))
    when BatBig_int.ge_big_int (BatBig_int.add n1 n2) n3
         && BatBig_int.ge_big_int (BatBig_int.of_int 255) (BatBig_int.add n1 n2)
    -> true
  | Imply (_,VBinRel (VGeq, (* e.g., 50 + (exp/3) *)
                      VBinOp (VAdd, VInt n1, VBinOp (VDiv,_,VInt n2,_), _),
                      VInt n3))
    when BatBig_int.equal n1 n3 ->
    let max = Lang.max_256bit in
    let added = BatBig_int.add n1 (BatBig_int.div max n2) in
    let test = BatBig_int.le_big_int added max in
    test
  | Imply (pre,con) when template10 vf -> true
  | Imply (pre,con) when template11 vf -> true
  | Imply (pre,con) ->
    if has_sigeq vf || has_noflow vf then
      template0 vf || template1 vf || template2 vf || template3 vf || template4 vf
    else template5 vf || template6 vf || template7 vf || template8 vf || template9 vf (* if false, will be checked by Z3 *)
  | _ -> false
