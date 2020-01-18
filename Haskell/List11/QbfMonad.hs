data Inc v = Z | S v

data Formula v =
  Var v
  | Bot
  | Not (Formula v)
  | And (Formula v) (Formula v)
  | All (Formula (Inc v))

instance Functor Inc where

instance Applicative Inc where

instance Functor Formula where

instance Applicative Formula where

instance Monad Formula where
  return = pure
  (Var)