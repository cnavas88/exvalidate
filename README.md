# Exvalidate

**TODO: Add description**

## Installation

The package can be installed by adding `exvalidate` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exvalidate, git: "https://github.com/cnavas88/exvalidate.git"}
  ]
end
```

## Use as a plug

if you want use the exvalidate as a plug, add the next lines into the 
plug router file:

```elixir
  alias Exvalidate.Plug, as: PlugValidate
  alias Exvalidate.PlugError

  plug(:match)
  plug(PlugValidate, on_error: &PlugError.json_error/2)
  plug(:dispatch)
```

You can change the on_error handler function according your requeriments:
- return a json, use: &PlugError.json_error/2
- return a text plain, use: &PlugError.plain_error/2 
- custom: you can use a custom function. This function has return a conn object.

Finish: for finish you have add the next line in the router api:

- For validate a query string request
```elixir
  get "/test", private: %{validate_query: @schema}
```

- For validate a body request
```elixir
  get "/test", private: %{validate_body: @schema}
```

## Validate dates

if you only want validate a data. You follow the next steps:

- add the alias to the file: 
```elixir
  alias Exvalidate
```

- call to the function validate, where data is a map with the data to validate,
and the schema is the validate schema to use for validate data:
```elixir
  Exvalidate.validate(data, schema)
```

## VALIDATE RULES

You can use the next rules for validate params:

- required: Setting `:required` to `true` will cause a validation error
when a field is not present or the value is `nil` or `""`. 

```elixir
%{
  "id" => %{
    "required" => true
  }
}
```

- default: if this rule has a value, find the content into the param, if is not
present adding this value into the param assing.

```elixir
%{
  "id" => %{
    "default" => 5
  }
}
```

- in: Validate that the value or list of values are into the list.

```elixir
%{
  "id" => %{
    "in" => [1, 2, 3]
  }
}
```

- length: Validate that the param has the exact length. (Is for lists or string)

```elixir
%{
  "name" => %{
    "length" => 5
  }
}
```

- max_length: Validate that the param must be lower than or equal to min 
length value.

```elixir
%{
  "name" => %{
    "max_length" => 5
  }
}
```

- min_length: Validate that the param must be greater than or equal to min 
length value.

```elixir
%{
  "name" => %{
    "min_length" => 5
  }
}
```