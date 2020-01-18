type 'a dllist = 'a dllist_data lazy_t
and 'a dllist_data = {
  prev: 'a dllist;
  elem: 'a;
  next: 'a dllist
}

let rec of_list list = match list with
  | hd :: tl -> {
    prev=lazy (
      of_list (match List.rev list with
        | hd :: tl -> hd :: List.rev tl
      )
    );
    elem=hd;
    next=lazy (of_list (tl @ [hd]))
  }

let prev dllst = Lazy.force dllst.prev
let elem dllst = dllst.elem
let next dllst = Lazy.force dllst.next