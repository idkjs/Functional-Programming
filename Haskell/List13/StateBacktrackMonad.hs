import Control.Monad
import Control.Applicative
import Control.Monad.State.Class

newtype SBT1 s a = SBT1 { runSBT1 :: s -> [(a, s)]}

instance Functor (SBT1 s) where
  fmap = liftM

instance Applicative (SBT1 s) where
  pure = return
  (<*>) = ap

instance Monad (SBT1 s) where
  return a = SBT1 $ \s -> [(a, s)]
  (SBT1 x) >>= f = SBT1 $ \s -> 
    let xs = x s
    in xs >>= (\(v, s') -> runSBT1 (f v) s')

instance Alternative (SBT1 s) where
  empty = mzero
  (<|>) = mplus

instance MonadPlus (SBT1 s) where
  mzero = SBT1 $ \s -> []
  (SBT1 f) `mplus` (SBT1 g) = SBT1 $ \s -> (f s) ++ (g s)

instance MonadState (SBT1 s) s where
  get = SBT1 $ \s -> [(s,s)]
  put s = SBT1 $ \_ -> [((), s)]
