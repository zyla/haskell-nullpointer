# `Data.NullPointer`

Tired of using `Maybe`? Wrapping values in `Just` makes you sick?
Missing your `NullPointerException`s?
Add null value to any data type using `Data.NullPointer`!

## Example

```haskell
import Prelude hiding (null)
import System.Environment (getArgs)
import Data.NullPointer

getFirstArg :: [String] -> String
getFirstArg (x:_) = x
getFirstArg [] = null

main = do
  arg <- getFirstArg <$> getArgs

  if isNull arg
    then putStrLn "No argument passed"
    else putStrLn arg
```

## What if I forget to check if a value is null?

You'll get a `NullPointerException`, just like in Java! Brillant!
