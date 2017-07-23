import Html exposing (Html, div, h1, input, text)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import Table



main =
  Html.program
    { init = init states
    , update = update
    , view = view
    , subscriptions = \_ -> Sub.none
    }



-- MODEL


type alias Model =
  { people : List Capital
  , tableState : Table.State
  , query : String
  }


init : List Capital -> ( Model, Cmd Msg )
init people =
  let
    model =
      { people = people
      , tableState = Table.initialSort "Name"
      , query = ""
      }
  in
    ( model, Cmd.none )



-- UPDATE


type Msg
  = SetQuery String
  | SetTableState Table.State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SetQuery newQuery ->
      ( { model | query = newQuery }
      , Cmd.none
      )

    SetTableState newState ->
      ( { model | tableState = newState }
      , Cmd.none
      )



-- VIEW


view : Model -> Html Msg
view { people, tableState, query } =
  let
    lowerQuery =
      String.toLower query

    acceptablePeople =
      List.filter (String.contains lowerQuery << String.toLower << .name) people
  in
    div []
      [ h1 [] [ text "Buscar capital de um estado" ]
      , input [ placeholder "Letras inicias do estado", onInput SetQuery ] []
      , Table.view config tableState acceptablePeople
      ]


config : Table.Config Capital Msg
config =
  Table.config
    { toId = .name
    , toMsg = SetTableState
    , columns =
        [ Table.stringColumn "Name" .name
        , Table.stringColumn "Capital" .city
        ]
    }



-- States


type alias Capital =
  { name : String
  , city : String
  }


states : List Capital
states =
  [ Capital "Amazonas" "Manaus"
  , Capital "São Paulo" "São Paulo"
  , Capital "Roraima" "Boa Vista"
  , Capital "Rio de Janeiro" "Rio de Janeiro"
  , Capital "Bahia" "Salvador"
  , Capital "Rio Grande do Sul" "Porto Alegre"
  , Capital "Rio Grande do Norte" "Natal"
  , Capital "Rondônia" "Porto Velho"
  , Capital "Pará" "Belém"
  , Capital "Mato Grosso" "Cuiabá"
  , Capital "Mato Grosso do Sul" "Campo Grande"
  , Capital "Acre" "Rio Branco"
  , Capital "Espírito Santo" "Vitória"
  , Capital "Santa Catarina" "Florianópolis"
  , Capital "Paraná" "Curitiba"
  , Capital "Alagoas" "Maceió"
  , Capital "Amapá" "Macapá"
  , Capital "Ceará" "Fortaleza"
  , Capital "Distrito Federal" "Brasília"
  , Capital "Goiás" "Goiânia"
  , Capital "Maranhão" "São Luís"
  , Capital "Paraíba" "João Pessoa"
  , Capital "Pernambuco" "Recife"
  , Capital "Piauí" "Teresina"
  , Capital "Sergipe" "Aracaju"
  , Capital "Tocantis" "Palmas"

  ]
