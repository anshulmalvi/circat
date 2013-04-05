{-# LANGUAGE TypeOperators #-}
{-# OPTIONS_GHC -Wall #-}

-- {-# OPTIONS_GHC -fno-warn-unused-imports #-} -- TEMP
-- {-# OPTIONS_GHC -fno-warn-unused-binds   #-} -- TEMP

----------------------------------------------------------------------
-- |
-- Module      :  Circat.Misc
-- Copyright   :  (c) 2013 Tabula, Inc.
-- 
-- Maintainer  :  conal@tabula.com
-- Stability   :  experimental
-- 
-- Miscellany
----------------------------------------------------------------------

module Circat.Misc where

-- TODO: explicit exports

import Prelude hiding (id,(.))

import Control.Category (Category(..))
import Control.Newtype


{--------------------------------------------------------------------
    Misc
--------------------------------------------------------------------}

type Unop a = a -> a

-- Sum & product type synonyms

infixl 7 :*
infixl 6 :+

type (:+) = Either
type (:*) = (,)

inNew :: (Newtype n o, Newtype n' o') =>
         (o -> o') -> (n -> n')
inNew = pack <~ unpack

inNew2 :: (Newtype n o, Newtype n' o', Newtype n'' o'') =>
          (o -> o' -> o'') -> (n -> n' -> n'')
inNew2 = inNew <~ unpack


infixl 1 <~

-- | Add post- and pre-processing
(<~) :: Category cat =>
        (b `cat` b') -> (a' `cat` a) -> ((a `cat` b) -> (a' `cat` b'))
(h <~ f) g = h . g . f