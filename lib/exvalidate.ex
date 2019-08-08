defmodule Exvalidate do
  @moduledoc """

  """

  @spec validate(map, map) :: {:ok, map} | {:error, String.t()}
  def validate(data, schema) do
    IO.puts "DATA :: #{inspect data}"
    IO.puts "SCHEMA :: #{inspect schema}"
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
