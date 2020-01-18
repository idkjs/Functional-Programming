qsortBy :: (a -> a  -> Bool) -> [a] -> [a]
qsortBy p [] = []
qsortBy p (hd : tl) =
  qsortBy p [x | x <- tl, p x hd]
  ++ [hd]
  ++ (qsortBy p [x | x <- tl, not (p x hd)])