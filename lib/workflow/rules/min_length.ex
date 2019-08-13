defmodule Exvalidate.Rules.MinLength do
  @moduledoc """

  """

  @spec validating(map, String.t, map) :: {:ok, map} | {:error, String.t}

  def validating(%{"min_length" => min}, field, data)
    when is_integer(min) do
      case is_greater_than(min, Map.get(data, field)) do
        {:ok, true} ->
          {:ok, data}

        {:ok, false} ->
          {:error, "#{field} must be greater than or equal to #{min}."}

        {:error, msg} ->
          {:error, msg}
      end
  end
  def validating(_, _, _), do: {:error, "The rules min_length is wrong."}

  @spec is_greater_than(number, any) :: {:ok, boolean} | {:error, String.t}

  defp is_greater_than(min, value)
    when is_binary(value) do
      {:ok, String.length(value) > min}
  end
  defp is_greater_than(min, value) do
    {:error, "The field has to be a String."}
  end
end
