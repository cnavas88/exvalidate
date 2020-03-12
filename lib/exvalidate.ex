defmodule Exvalidate do
  @moduledoc """
  Enter point for validate data structure.
  """
  alias Exvalidate.Validate

  @deps %{
    validate: &Validate.rules/3
  }

  @spec validate(map(), map(), map()) :: {:ok, map()} | {:error, String.t()}

  def validate(data, schema, deps \\ @deps) do
    with :ok <- validate_allowed_params(data, schema),
         {:ok, new_data} <- validate_schema(data, schema, deps) do
      {:ok, new_data}
    else
      {:error, msg} -> {:error, msg}
    end
  end

  @spec validate_allowed_params(map(), map()) :: :ok | {:error, String.t()}

  defp validate_allowed_params(data, schema) do
    case Map.keys(schema) -- Map.keys(data) do
      [] -> :ok
      [field | _rest] -> {:error, "#{field} is not allowed"}
    end
  end

  @spec validate_schema(map(), map(), map()) ::
          {:ok, map()} | {:error, String.t()}

  defp validate_schema(data, schema, deps) do
    Enum.reduce_while(schema, {:ok, data}, fn {field, rules}, {:ok, modified_data} ->
      case deps.validate.(field, rules, modified_data) do
        {:ok, new_data} ->
          {:cont, {:ok, new_data}}

        {:error, msg} ->
          {:halt, {:error, msg}}
      end
    end)
  end
end
