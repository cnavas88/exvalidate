defmodule Exvalidate do
  @moduledoc """

  """
  alias Exvalidate.Validate

  def validate(data, schema) do
    with :ok              <- validate_allowed_params(data, schema),
         {:ok, new_data}  <- validate_schema(data, schema)
    do
      {:ok, new_data}
    else
      {:error, msg} -> {:error, msg}
    end
  end

  defp validate_allowed_params(data, schema) do
    result = Map.keys(schema) -- Map.keys(data)

    case result do
      [] -> :ok
      [field | _rest] -> {:error, "#{field} is not allowed"}
    end
  end

  defp validate_schema(data, schema) do
    Enum.reduce_while(schema, {:ok, data}, fn {field, rules}, {:ok, modified_data} ->
      case Validate.rules(field, rules, modified_data) do
        {:ok, new_data} ->
          {:cont, {:ok, new_data}}

        {:error, msg} ->
          {:halt, {:error, msg}}
      end
    end)
  end
end
