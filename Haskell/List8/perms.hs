iperm :: [a] -> [[a]]
iperm [] = [[]]
iperm (hd : tl) = concatMap (insert hd) (iperm tl)
  where insert :: a -> [a] -> [[a]]
        insert el lst = [pref ++ (el : suff) | n <- [0..(length lst)],
                                               let pref = (take n lst),
                                               let suff = (drop n lst)] 

sperm :: [a] -> [[a]]
sperm [] = [[]]
sperm lst = [el : perm | (el, rest) <- select lst, perm <- sperm rest]
  where select :: [a] -> [(a, [a])]
        select [] = []
        select lst = [(hd, pref ++ suff) | n <- [0..((length lst) - 1)],
                                           let (pref, (hd : suff)) = splitAt n lst]
  