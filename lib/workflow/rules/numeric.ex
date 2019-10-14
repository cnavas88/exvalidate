defmodule Exvalidate.Rules.Numeric do
  @moduledoc """
  This module validate that the value is a number
  """

  @spec validating(map, String.t(), map) :: {:ok, map} | {:error, String.t()}

  def validating(%{"numeric" => is_num}, field, data)
    when is_boolean(is_num) do
      case is_numeric(is_num, Map.get(data, field)) do
        {:ok, true} ->
          {:ok, data}

        {:ok, false} ->
          {:error, "#{field} is not a numeric."}
      end
  end
  def validating(_, _, _), do: {:error, "The rules numeric is wrong."}

  @spec is_numeric(number, any) :: {:ok, boolean} | {:error, String.t()}

  defp is_numeric(true, value) when is_number(value), do:
    {:ok, true}

  defp is_numeric(false, _value), do: {:ok, false}
end
