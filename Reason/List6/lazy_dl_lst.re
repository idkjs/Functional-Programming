type dllist('a) = lazy_t(dllist_data('a))
and dllist_data('a) = {
  prev: dllist('a),
  elem: 'a,
  next: dllist('a),
};

let rec of_list = list =>
  switch (list) {
  | [hd, ...tl] => {
      prev:
        lazy(
          of_list(
            switch (List.rev(list)) {
            | [hd, ...tl] => [hd, ...List.rev(tl)]
            },
          )
        ),
      elem: hd,
      next: lazy(of_list(tl @ [hd])),
    }
  };

let prev = dllst => Lazy.force(dllst.prev);
let elem = dllst => dllst.elem;
let next = dllst => Lazy.force(dllst.next);
