import Data.Char

data StreamTrans i o a
  = Return a
  | ReadS (Maybe i -> StreamTrans i o a)
  | WriteS o (StreamTrans i o a)

toLower_ :: StreamTrans Char Char a
toLower_ = ReadS transform
  where
    transform :: Maybe Char -> StreamTrans Char Char a
    transform (Just c) = WriteS (toLower c) toLower_
    transform Nothing = Return undefined

runIOStreamTrans :: StreamTrans Char Char a -> IO a
runIOStreamTrans (Return c) = return c
runIOStreamTrans (ReadS f) = do
  c <- getChar
  if c /= '\n'
    then runIOStreamTrans $ f (Just c)
    else runIOStreamTrans $ f Nothing
runIOStreamTrans (WriteS o streamT) = do
  putChar o
  runIOStreamTrans streamT

listTrans :: StreamTrans i o a -> [i] -> ([o], a)
listTrans (ReadS transform) xs =
  let
    listTransHelper :: StreamTrans i o a -> [i] -> [o] -> ([o], a)
    listTransHelper (WriteS o streamT) inp out = listTransHelper streamT inp (o : out)
    listTransHelper (ReadS f) (x : xs) out =  listTransHelper (f (Just x)) xs out
    listTransHelper (ReadS f) [] out = listTransHelper (f Nothing) [] out
    listTransHelper (Return x) _ out = (reverse out, x)
  in listTransHelper (ReadS transform) xs []
