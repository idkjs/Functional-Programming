type Symbol = String

data Term v =
  Var v
  | Sym Symbol [Term v]
  deriving (Show)

instance Functor Term where
  fmap f (Sym symbol termList) = (Sym symbol (map (fmap f) termList))
  fmap f (Var v) = (Var (f v))

instance Applicative Term where
  pure f = Var f
  Var f <*> Var x = Var (f x)
  Var f <*> Sym symbol termList = fmap f (Sym symbol termList)

instance Monad Term where
  return = pure
  (Var v) >>= f = f v
  (Sym symbol termList) >>= f = (Sym symbol (map (\x -> x >>= f) termList))