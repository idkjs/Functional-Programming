(* Church boolean encoding *)

let ctrue x _ = x;;

let cfalse _ y = y;;

let cand cbool_p cbool_q = cbool_p cbool_q cfalse;;

let cor cbool_p cbool_q = cbool_p ctrue cbool_q;;

let cbool_of_bool p = if p then ctrue else cfalse;;

let bool_of_cbool cbool = cbool true false;;