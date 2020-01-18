import Data.List
import Control.Monad

newtype RS a = RS { unRS :: Int -> (Int, a) }

class Monad m => Random m where
  rand :: m Int

instance Functor RS where
  fmap = liftM

instance Applicative RS where
  pure = return
  (<*>) = ap 

instance Monad RS where
  return a = RS (\x -> (x, a))

  RS f >>= g = RS (\x -> unRS (g $ snd $ f x) x)

instance Random RS where
  rand = RS {
    unRS = \x -> let nextSeed = if x > 0 then x else x + 2147483647
    in (nextSeed, 16807 * (x `mod` 127773) - 2836 * (x `div` 1277773))
  }

withSeed :: RS a -> Int -> a
withSeed (RS f) seed = snd $ f seed

shuffle :: Random m => [a] -> m [a]
shuffle xs =
  let perms = permutations xs
      permLen = (length xs)
  in rand >>= (\randInd -> return (perms !! (randInd `mod` permLen)))