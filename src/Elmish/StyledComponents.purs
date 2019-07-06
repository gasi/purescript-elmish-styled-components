module Elmish.StyledComponents
  ( styled
  , styled'
  ) where

import Elmish.React.Import (ImportedReactComponent)

styled
  :: forall props styles
   . ImportedReactComponent
  -> (props -> { | styles })
  -> ImportedReactComponent
styled = styled_

styled'
  :: forall props
   . ImportedReactComponent
  -> (props -> String)
  -> ImportedReactComponent
styled' = styled_

foreign import styled_
  :: forall a
   . ImportedReactComponent
  -> a
  -> ImportedReactComponent
