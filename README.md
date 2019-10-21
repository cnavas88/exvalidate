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
