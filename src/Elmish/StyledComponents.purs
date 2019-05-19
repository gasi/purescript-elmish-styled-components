module Elmish.StyledComponents
  ( styled
  ) where

import Elmish.React.Import (ImportedReactComponent)

foreign import styled
  :: forall props styles
   . ImportedReactComponent
  -> (props -> { | styles })
  -> ImportedReactComponent
