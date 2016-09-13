{-# LANGUAGE MagicHash #-}

-- | Adds @null@ value to any Haskell data type.
module Data.NullPointer (null, isNull, NullPointerException(..)) where

import Prelude hiding (null)
import Control.Exception (Exception, throw)
import GHC.Prim (reallyUnsafePtrEquality#)

-- | The null value.
-- When forced, a NullPointerException will be thrown.
null :: a
null = throw NullPointerException
{-# NOINLINE null #-}

-- | Check whether the given value is 'null'.
isNull :: a -> Bool
isNull x =
  case reallyUnsafePtrEquality# x null of
    0# -> x `seq` False -- isNull should be strict in all values except null
    _ -> True

-- | Thrown on attempt to use 'null'.
data NullPointerException = NullPointerException deriving (Eq, Show)

instance Exception NullPointerException
