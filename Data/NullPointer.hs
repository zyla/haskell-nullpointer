-- | Adds @null@ value to any Haskell data type.
module Data.NullPointer (null, isNull, NullPointerException(..)) where

import Prelude hiding (null)
import Control.Exception (Exception, throw, catch, evaluate)
import System.IO.Unsafe (unsafePerformIO)

-- | The null value.
-- When forced, a NullPointerException will be thrown.
null :: a
null = throw NullPointerException

-- | Check whether the given value is 'null'.
isNull :: a -> Bool
isNull x = unsafePerformIO ((evaluate x >> pure False) `catch` \NullPointerException -> pure True)

-- | Thrown on attempt to use 'null'.
data NullPointerException = NullPointerException deriving (Eq, Show)

instance Exception NullPointerException
