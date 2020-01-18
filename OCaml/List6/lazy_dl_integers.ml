type 'a dllist = 'a dllist_data lazy_t
and 'a dllist_data =
  { prev: 'a dllist;
    elem: 'a;
    next: 'a dllist
}

let lazy_dl_ints = 
  let rec helper start = {
      prev=lazy (helper (start - 1));
      elem=start;
      next=lazy (helper (start + 1))
  }
  in helper 0
    
let prev dllst = Lazy.force dllst.prev
let elem dllst = dllst.elem
let next dllst = Lazy.force dllst.next