module Main where

import Prelude

import CSS (CSS, backgroundColor, black, color, display, fontFamily, fontSize, fromString, hover, inlineBlock, marginLeft, marginTop, padding, px, query, rem, render, renderedInline, renderedSheet, sansSerif, with, (?))
import CSS.Media (maxWidth, screen)
import CSS.Selector (Selector)
import Color (white)
import Color.Scheme.Clrs (lime)
import Color.Scheme.X11 (green, pink, red, violet)
import Data.Maybe (fromJust)
import Data.NonEmpty (singleton)
import Effect (Effect)
import Elmish.Browser (QuerySelector(..))
import Elmish.Browser as Browser
import Elmish.HTML (h1) as R
import Elmish.HTML.Internal (unsafeCreateDOMComponent)
import Elmish.React (createElement)
import Elmish.React.DOM (fragment) as R
import Elmish.React.Import (EmptyProps, ImportedReactComponentConstructorWithContent)
import Elmish.StyledComponents (styled, styled')
import Partial.Unsafe (unsafePartial)

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
    [ R.h1 {} "Style object"
    , todoItem { completed: true } "Apple"
    , todoItem { completed: false } "Banana"
    , todoItem { completed: true } "Orange"

    , R.h1 {} "Type-safe CSS"
    , todoItem' { completed: true } "Apple"
    , todoItem' { completed: false } "Banana"
    , todoItem' { completed: true } "Orange"
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
      , "@media (max-width: 800px)":
          { backgroundColor:
              if props.completed
                then "violet"
                else "pink"
          }
      }

self :: Selector
self = fromString "&"

todoItem' :: ImportedReactComponentConstructorWithContent TodoItem EmptyProps
todoItem' = createElement $
  styled'
    (unsafeCreateDOMComponent "div")
    \props -> css do
      display inlineBlock
      fontSize (20.0 # px)
      fontFamily ["Helvetica", "Arial"] (singleton sansSerif)
      marginTop $ 1.0 # rem
      marginLeft $ 10.0 # px
      padding (1.0 # rem) (2.0 # rem) (1.0 # rem) (2.0 # rem)
      color white
      backgroundColor pink
      backgroundColor $
        if props.completed
          then green
          else red
      self `with` hover ? do
        backgroundColor black
        color lime
      query screen (singleton $ maxWidth (800.0 # px)) do
        self ? do
          backgroundColor
              if props.completed
                then violet
                else pink

css :: CSS -> String
css s =
  (unsafePartial $ fromJust $ renderedInline $ render s)
  <> "; " <>
  (unsafePartial $ fromJust $ renderedSheet $ render s)
