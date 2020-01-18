sublists :: [a] -> [[a]]
sublists [] = [[]]
sublists (hd : tl) = concatMap (\lst -> [lst, hd : lst]) (sublists tl)