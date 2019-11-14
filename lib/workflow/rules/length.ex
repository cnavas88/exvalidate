defmodule Exvalidate.Rules.Length do
  @moduledoc """
  This rules Specifies the exact number of characters allowed in the
  string or exact number of items in the lisdt. Allowed values are 
  non-negative integers.
  """
  @behaviour Exvalidate.Rules.IRules
  
  @spec validating(map, String.t(), map) :: {:ok, map} | {:error, String.t()}

  def validating(%{"length" => length}, field, data)
      when is_integer(length) and length > 0 do
    case exact_length(length, Map.get(data, field)) do
      {:ok, true} ->
        {:ok, data}

      {:ok, false} ->
        {:error, "#{field} must be equal than #{length}."}

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _, _), do: {:error, "The rule length is wrong."}

  @spec exact_length(number, any) :: {:ok, boolean} | {:error, String.t()}

  defp exact_length(length, value)
       when is_binary(value) do
    {:ok, String.length(value) == length}
  end

  defp exact_length(length, value)
       when is_list(value) do
    {:ok, Enum.count(value) == length}
  end

  defp exact_length(_length, _value) do
    {:error, "The field has to be a String or list."}
  end
end
