(><) :: [a] -> [b] -> [(a, b)]
(><) xLst yLst =
  [(xLst !! (x - y), yLst !! y) | x <- ( map snd $ zip xLst [0..]),
                                  y <- (map snd $ zip yLst [0..x])]