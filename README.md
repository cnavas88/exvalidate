![Elixir CI](https://github.com/cnavas88/exvalidate/workflows/Elixir%20CI/badge.svg?branch=master)

# Exvalidate

**TODO: Add description**

## Installation

The package can be installed by adding `exvalidate` to your list of dependencies
 in `mix.exs`:

```elixir
def deps do
  [
    {:exvalidate, git: "https://github.com/cnavas88/exvalidate.git"}
  ]
end
```

## Use as a Plug

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

## Validate data

If you only want to validate data you can do so by:

- adding the alias to the file: 

```elixir
  alias Exvalidate
```

- calling the `validate` function, where data is a map with the data to validate
and the schema is the validate schema to use for data validation:

```elixir
  Exvalidate.validate(data, schema)
```

## Validation rules

You can use the following rules to validate parameters:

- required: Setting `:required` to `true` will cause a validation error
when a field is not present or the value is `nil` or `""`. 

```elixir
%{
  "id" => %{
    "required" => true
  }
}
```

- default: if this rule has a value, use it, if not assign it the default value.

```elixir
%{
  "id" => %{
    "default" => 5
  }
}
```

- in: Validate that the value or list of values belongs to the given list.

```elixir
%{
  "id" => %{
    "in" => [1, 2, 3]
  }
}
```

- length: Validate that the param has the given length.
(Can be used with lists or strings)

```elixir
%{
  "name" => %{
    "length" => 5
  }
}
```

- max_length: Validates the parameter is <= to the given value.

```elixir
%{
  "name" => %{
    "max_length" => 5
  }
}
```

- min_length: Validates the parameter is >= to the given value.

```elixir
%{
  "name" => %{
    "min_length" => 5
  }
}
```
