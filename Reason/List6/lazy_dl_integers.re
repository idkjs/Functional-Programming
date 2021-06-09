type dllist('a) = lazy_t(dllist_data('a))
and dllist_data('a) = {
  prev: dllist('a),
  elem: 'a,
  next: dllist('a),
};

let lazy_dl_ints = {
  let rec helper = start => {
    prev: lazy(helper(start - 1)),
    elem: start,
    next: lazy(helper(start + 1)),
  };
  helper(0);
};

let prev = dllst => Lazy.force(dllst.prev);
let elem = dllst => dllst.elem;
let next = dllst => Lazy.force(dllst.next);
