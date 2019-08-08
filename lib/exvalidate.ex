defmodule Exvalidate do
  @moduledoc """

  """
  alias Exvalidate.Rules.Type

  def validate(data, schema) do
    IO.puts "DATA :: #{inspect data}"
    IO.puts "SCHEMA :: #{inspect schema}"
    case Type.validate(schema) do
      {:ok, module} ->
        validate_schema(data, schema, module)

      {:error, msg} ->
        {:error, msg}
    end
  end

  defp validate_schema(data, schema, module) do
    {:ok, data}
  end

  # @spec validate_allowed_params(map, map) :: :ok | {:error, String.t()}
  # defp validate_allowed_params(data, schema) do
  #   result = Map.keys(data) -- Map.keys(schema)
  #   IO.puts "MAP KEYS :: #{inspect Map.keys(data)}"
  #   IO.puts "MAP SCHEMA :: #{inspect Map.keys(schema)}"

  #   case result do
  #     [] -> :ok
  #     [field | _rest] -> {:error, "#{field} is not allowed"}
  #   end
  # end

  # @spec validate_schema(map, map) :: {:ok, map} | {:error, String.t()}
  # defp validate_schema(data, schema) do
  #   Enum.reduce_while(schema, {:ok, data}, fn {field, type}, {:ok, modified_data} ->
  #     case Type.validate(type, field, modified_data) do
  #       {:error, msg} ->
  #         {:halt, {:error, msg}}

  #       {:ok, new_data} ->
  #         {:cont, {:ok, new_data}}
  #     end
  #   end)
  # end
end
