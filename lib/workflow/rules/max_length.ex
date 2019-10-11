defmodule Exvalidate.Rules.MaxLength do
  @moduledoc """
  This module validate the length of list and strings
  """

  @spec validating(map, String.t(), map) :: {:ok, map} | {:error, String.t()}

  def validating(%{"max_length" => max}, field, data)
      when is_integer(max) do
    case is_lower_than(max, Map.get(data, field)) do
      {:ok, true} ->
        {:ok, data}

      {:ok, false} ->
        {:error, "#{field} must be lower than or equal to #{max}."}

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _, _), do: {:error, "The rules max_length is wrong."}

  @spec is_lower_than(number, any) :: {:ok, boolean} | {:error, String.t()}

  defp is_lower_than(max, value)
       when is_binary(value) do
    {:ok, String.length(value) <= max}
  end

  defp is_lower_than(max, value)
       when is_list(value) do
    {:ok, Enum.count(value) <= max}
  end

  defp is_lower_than(_max, _value) do
    {:error, "The field has to be a String or list."}
  end
end
