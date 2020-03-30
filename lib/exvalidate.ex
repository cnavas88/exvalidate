defmodule Exvalidate do
  @moduledoc """
  Enter point for validate data structure.
  """
  alias Exvalidate.Validate

  @validate_fn &Validate.rules/2

  @spec validate(map(), map(), function()) :: 
    {:ok, map()} | {:error, String.t()}

  def validate(data, schema, validate_fn \\ @validate_fn) do
    with :ok              <- validate_allowed_params(data, schema),
         {:ok, new_data}  <- validate_schema(data, schema, validate_fn) 
    do
      {:ok, new_data}
    else
      {:error, msg} -> {:error, msg}
    end
  end

  defp validate_allowed_params(data, schema) do
    case Keyword.keys(schema) -- keys_to_atom(Map.keys(data)) do
      [] -> 
        :ok

      [field | _rest] -> 
        {:error, "#{field} is not allowed."}
    end
  end

  defp keys_to_atom(keys) do
    Enum.map(keys, &(String.to_atom(&1)))
  end

  def validate_schema(data, schema, validate_fn) do
    data = %{
      "id" => "1234",
      "lastname" => "Navas Buzon",
      "name" => "Carlos",
      "email" => "dante@gmail.com"
    }

    schema = [
      lastname: [:required, length: 11],
      id: [:required, type: :integer],
      name: [:required, max_length: 10],
      email: [:email]
    ]

    Enum.reduce_while(schema, {:ok, data}, &validating(&1, &2, validate_fn))
  end

  defp validating({key, rules}, {:ok, data}, validate_fn) do
    parse_key = Atom.to_string(key)

    case validate_fn.(rules, Map.get(data, parse_key)) do
      {:ok, data_validate} ->
        modified_data = Map.put(data, parse_key, data_validate)
        {:cont, {:ok, modified_data}}

      {:error, msg} ->
        {:halt, {:error, key, msg}}
    end
  end
end
