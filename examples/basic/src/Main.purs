module Main where

import Prelude

import Effect (Effect)

import Elmish.Browser (QuerySelector(..))
import Elmish.Browser as Browser
import Elmish.HTML.Internal (unsafeCreateDOMComponent)
import Elmish.React (createElement)
import Elmish.React.DOM as R
import Elmish.React.Import (EmptyProps, ImportedReactComponentConstructorWithContent)
import Elmish.StyledComponents (styled)


main :: Effect Unit
main =
  Browser.sandbox (QuerySelector "#app")
    { init
    , view
    , update
    }

  where

  init = pure unit
  view _ _ = R.fragment
    [ todoItem { completed: true } "Apple"
    , todoItem { completed: false } "Banana"
    , todoItem { completed: true } "Orange"
    ]
  update _ _ = init


-- TodoItem
type TodoItem r =
  ( completed :: Boolean
  | r
  )

todoItem :: ImportedReactComponentConstructorWithContent TodoItem EmptyProps
todoItem = createElement $
  styled
    (unsafeCreateDOMComponent "div")
    \props ->
      { display: "inline-block"
      , fontSize: "20px"
      , fontFamily: "Helvetica, Arial, sans-serif"
      , padding: "1rem 2rem"
      , color: "white"
      , marginLeft: "10px"
      , backgroundColor:
          if props.completed
            then "green"
            else "red"
      , "&:hover":
          { backgroundColor: "black"
          , color: "#0f0"
          , cursor: "pointer"
          }
      , "@media (min-width: 800px)":
          { backgroundColor:
              if props.completed
                then "violet"
                else "pink"
          }
      }
