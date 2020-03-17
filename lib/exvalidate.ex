defmodule Exvalidate do
  @moduledoc """
  Enter point for validate data structure.
  """
  alias Exvalidate.Validate

  @validate_fn &Validate.rules/3

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
    case Map.keys(schema) -- Map.keys(data) do
      [] -> 
        :ok

      [field | _rest] -> 
        {:error, "#{field} is not allowed"}
    end
  end

  defp validate_schema(data, schema, validate_fn) do
    Enum.reduce_while(schema, {:ok, data}, &validating(&1, &2, validate_fn))
  end

  defp validating({key, rules}, {:ok, data}, validate_fn) do
    parse_key = Atom.to_string(key)
    data_to_validate = Map.get(data, parse_key)
    
    case validate_fn.(key, rules, data_to_validate) do
      {:ok, data_validate} ->
        modified_data = Map.put(data, parse_key, data_validate)
        {:cont, {:ok, modified_data}}

      {:error, msg} ->
        {:halt, {:error, msg}}
    end
  end
end
