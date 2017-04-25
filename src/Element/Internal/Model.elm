module Element.Internal.Model exposing (..)

{-| -}

import Element.Style.Internal.Model as Internal
import Html exposing (Html)
import Color exposing (Color)


type ElementSheet elem variation animation msg
    = ElementSheet
        { defaults : Defaults
        , stylesheet : Internal.StyleSheet elem variation animation msg
        }


type alias Defaults =
    { typeface : List String
    , fontSize : Float
    , lineHeight : Float
    , spacing : ( Float, Float, Float, Float )
    , textColor : Color
    }


type Element elem variation msg
    = Empty
    | Text Decoration String
    | Element (Maybe elem) (List (Attribute variation msg)) (Element elem variation msg) (Maybe (List (Element elem variation msg)))
    | Layout Internal.LayoutModel (Maybe elem) (List (Attribute variation msg)) (List (Element elem variation msg))


type Attribute variation msg
    = Vary variation Bool
    | LayoutAttr Internal.LayoutModel
    | Height Internal.Length
    | Width Internal.Length
    | Align Alignment
    | Position Int Int
    | PositionFrame Frame
    | Hidden
    | Transparency Int
    | Spacing ( Float, Float, Float, Float )
    | Padding ( Float, Float, Float, Float )
    | Event (Html.Attribute msg)
    | Attr (Html.Attribute msg)


type Decoration
    = NoDecoration
    | Bold
    | Italic
    | Underline
    | Strike


type Frame
    = Screen
    | Below
    | Above
    | OnLeft
    | OnRight



-- type Frame1
--     = Screen Anchor
--     | NearbyEl
--     | WithinEl Anchor
-- | TopRight
-- | TopLeft
-- | BottomRight
-- | BottomLeft


type Nearby element
    = Nearby element


type Inside element
    = Inside element


type Alignment
    = Left
    | Right
    | Top
    | Bottom


type alias HtmlFn msg =
    List (Html.Attribute msg) -> List (Html msg) -> Html msg


type Styled elem variation animation msg
    = El (HtmlFn msg) (List (Internal.Property elem variation animation))
