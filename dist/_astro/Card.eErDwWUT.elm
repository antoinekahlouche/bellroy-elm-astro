module Card exposing (main)

import Array exposing (..)
import Browser
import Html exposing (Html, a, div, h3, img, input, p, span)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Json.Decode exposing (Decoder, Value, decodeValue, field, map3, map5, string)



-- MAIN


main : Program Value Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }



-- FLAGS


type alias Flags =
    { product : Product }


type alias Product =
    { id : String
    , name : String
    , price : String
    , colors : Array Color
    , description : String
    }


type alias Color =
    { name : String
    , img : String
    , hex : String
    }


productDecoder : Decoder Product
productDecoder =
    map5 Product
        (field "id" string)
        (field "name" string)
        (field "price" string)
        (field "colors" colorsDecoder)
        (field "description" string)


colorsDecoder : Decoder (Array Color)
colorsDecoder =
    Json.Decode.array colorDecoder


colorDecoder : Decoder Color
colorDecoder =
    map3 Color
        (field "name" string)
        (field "img" string)
        (field "hex" string)


flagsDecoder : Decoder Flags
flagsDecoder =
    Json.Decode.map Flags
        (field "product" productDecoder)



-- MODEL


type alias Model =
    { product : Maybe Product, colorSelected : Int }


init : Value -> ( Model, Cmd Msg )
init flags =
    case decodeValue flagsDecoder flags of
        Ok { product } ->
            ( { product = Just product, colorSelected = 0 }, Cmd.none )

        Err _ ->
            ( { product = Nothing, colorSelected = 0 }, Cmd.none )



-- UPDATE


type Msg
    = SelectColor Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectColor index ->
            ( { model | colorSelected = index }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    case model.product of
        Just product ->
            div
                [ class "w-72 bg-[#f7f7f7] transition-all shadow hover:shadow-xl group/tile relative cursor-pointer"
                ]
                [ -- Image
                  div [ class "aspect-square" ]
                    [ div [ class "w-full h-full relative flex items-center justify-center" ]
                        [ img
                            [ class "w-full h-full object-center object-contain absolute inset-0"
                            , src (Array.get model.colorSelected product.colors |> Maybe.map .img |> Maybe.withDefault "")
                            ]
                            []
                        , div
                            [ class "absolute z-20 top-0 right-0 transition-opacity opacity-0 [@media(any-hover:hover)]:group-hover/tile:opacity-100 group"
                            ]
                            [ div
                                [ class "border-none outline-none py-1 px-2 uppercase text-sm bg-neutral-200 text-grey-600 rounded-bl"
                                ]
                                [ Html.text "Show inside"
                                ]
                            ]
                        ]
                    ]
                , div [ class "px-3 py-3 flex flex-col gap-1" ]
                    [ -- Title
                      h3
                        []
                        [ a
                            [ href ("/products/" ++ product.id)
                            , class "text-current no-underline"
                            ]
                            [ Html.text product.name
                            , span
                                [ class "absolute inset-0 z-10"
                                , attribute "aria-hidden" "true"
                                ]
                                []
                            ]
                        ]

                    -- Price
                    , div
                        [ class "font-semibold" ]
                        [ Html.text product.price ]

                    -- Colors
                    , div
                        [ class "inline-flex gap-3 py-3 max-w-full z-20 "
                        ]
                        (product.colors
                            |> Array.indexedMap
                                (\i color ->
                                    input
                                        [ type_ "radio"
                                        , classList
                                            [ ( "block relative appearance-none p-0 cursor-pointer rounded-full bg-cover w-[19px] h-[19px] outline-2 outline-transparent outline-offset-[-3px] hover:outline-white transition-all"
                                              , True
                                              )
                                            , ( "outline-white", i == model.colorSelected )
                                            ]
                                        , style "background-color" color.hex
                                        , style "border-color" color.hex
                                        , onClick (SelectColor i)
                                        ]
                                        []
                                )
                            |> Array.toList
                        )

                    -- Description
                    , p
                        [ class "text-grey-500 line-clamp-3 text-sm font-light" ]
                        [ Html.text product.name ]
                    ]
                ]

        Nothing ->
            div [ class "hidden" ] [ Html.text "Hiden div in case of a Decode error !" ]
