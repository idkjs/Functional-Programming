/* simulate a stream */

let hd = s => s(0);

let tl = (s, i) => s(i + 1);

let add = (c, s, i) => s(i) + c;

let map = (f, s, i) => f(s(i));

let map2 = (f, s1, s2, i) => f(s1(i), s2(i));

let replace = (n, a, s, i) =>
  if (i mod n === 0) {
    a;
  } else {
    s(i);
  };

let take = (n, s, i) => s(n * i);

let rec scan = (f, a, s, i) =>
  if (i === 0) {
    s(0);
  } else {
    f(scan(f, a, s, i - 1), s(i));
  };

let rec tabulate = (~l=0, r, s) =>
  if (l == r) {
    [];
  } else {
    [s(l), ...tabulate(~l=l + 1, r, s)];
  };

/* Instances of stream */
let s1 = i => i;
let s2 = i => i + 1;

/* See some results */
hd(s1);
tl(s1, 1);
add(2, s1, 1);
map(x => 2 * x, s1, 2);
map2((x, y) => x + y, s1, s2, 2);
replace(2, 0, s1, 4);
replace(2, 0, s1, 3);
take(3, s1, 2);
scan((acc, x) => acc + x, 0, s1, 4);
tabulate(5, s1);
tabulate(~l=1, 5, s1);
