primes' :: [Integer]
primes' = 2 : [x | x <- [3..], all (\y -> x `mod` y /= 0) (takeWhile (\y -> y*y <= x) primes')]