f :: [Integer] -> [Integer]
f [] = []
f (hd : tl) = [x | x <- tl, x `mod` hd /= 0]

primes :: [Integer]
primes = map head (iterate f [2..])