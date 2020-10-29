![Build CI](https://github.com/cnavas88/exvalidate/workflows/Elixir%20CI/badge.svg?branch=master)

# Exvalidate
 
exvalidate is a dependency that validates data in the form of maps from a data scheme. 
It is intended to make two types of validations. The first one is plug validation, 
in which there is created a middleware that we insert in our router and simply 
adding the private keyword with a scheme in each route we will be able to validate 
the data before they enter the controller. What makes that our controller only 
gets data correctly validated. The second part is to be able to validate the data 
in any part of a module, for this part there is the macro "validate".

## Installation

The package can be installed by adding `exvalidate` to your list of dependencies
 in `mix.exs`:

```elixir
def deps do
  [
    {:exvalidate, "~> 0.0.1"}
  ]
end
```

## Use as a Plug

If you want use `exvalidate` as a plug, add the next lines to your plug router 
file:

```elixir
  alias Exvalidate.Plug, as: PlugValidate
  alias Exvalidate.PlugError

  plug(:match)
  plug(PlugValidate, on_error: &PlugError.json_error/2)
  plug(:dispatch)
```

You can change the `on_error` handler function according your requirements: 
- return a json: `&PlugError.json_error/2`
- return plain text: `&PlugError.plain_error/2`
- custom: you can use a custom function. This function has to return a 
`Plug.Conn` object.

Finally, for the changes to take effect, you have add the next line in the 
router api:

- To validate a query string request

```elixir
  get "/test", private: %{validate_query: @schema}
```

- To validate a body request

```elixir
  get "/test", private: %{validate_body: @schema}
```

## Validate data

If you only want to validate data you can do so by:

- adding the alias to the file: 

```elixir
use Exvalidate
```

- calling the `validate` function, where data is a map with the data to validate
and the schema is the validate schema to use for data validation:

```elixir
validate(data, schema)
```

## Validation rules (SCHEMA)

You can use the following rules to validate data:

- required: Setting `:required` to `true` will cause a validation error
when a field is not present or the value is `nil` or `""`. 

```elixir
[
    id: [:required]
]
```

- between: The field under validation must have a size between the given min and max.
(you can validate strings, numbers, lists and tuples).

```elixir
[
    name: [between: {2, 5}]
]
```

- default: if this rule has a value, use it, if not assign it the default value.

```elixir
[
    name: [default: "Vegeta"]
]
```

- email: return ok if email is valid, an error if is invalid.

```elixir
[
    email: [:email]
]
```

- in: Validate that the value or list of values belongs to the given list.
(you can validate strings, numbers and lists).

```elixir
[
    name: [in: ["Vegeta", "Picolo", "Krilin"]]
]
```

- length: Validate that the param has the given length.
(Can be used with lists or strings)

```elixir
[
    name: [length: 5]
]
```

- max_length: Validates the parameter is <= to the given value.
(Can be used with lists, strings or tuples).

```elixir
[
    name: [max_length: 5]
]
```

- min_length: Validates the parameter is >= to the given value.
(Can be used with lists, strings or tuples).

```elixir
[
    name: [min_length: 5]
]
```

- accepted: The field under validation must be "yes", "on", 1, or true.

```elixir
[
    accept_conditions: [:accepted]
]
```

- type: This validation check the type of variable.
(Can be used to validate string, list, map, tuple, number, integer, float, atom, boolean).

```elixir
[
    name: [type: :string]
]
```

- nullable: Validate a field is nil or empty string.

```elixir
[
    name: [:nullable]
]
```

- password: Validate a field is a valid password.

```elixir
[
    password: [:password]
]
```

or 

```elixir
[
    password: [password: :CUSTOM_REGEX]
]
```

- IpV4: Validate a field is a ip v4 valid.

```elixir
[
    ip: [:ipv4]
]
```

or 

```elixir
[
    ip: [:ipv4]
]
```

## Error messages

we return an string of an error, however you want to receive the atom code, you can add to your config file the next line:

```elixir
config :exvalidate, show_messages: true
```

## Complete example

```elixir
schema = [
    id: [:required, :number],
    name: [:required, type: :string, max_length: 12, min_length: 2]
]

data = %{
    "id" => 35,
    "name" => "Vegeta"
}

validate(data, schema)
```
