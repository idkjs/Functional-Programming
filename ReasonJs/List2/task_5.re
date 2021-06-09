let rec suffixes = lst =>
  if (lst === []) {
    [[]];
  } else {
    [lst, ...suffixes(List.tl(lst))];
  };

let rec prefixes = lst => List.map(List.rev, suffixes(List.rev(lst)));
