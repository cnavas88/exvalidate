defmodule Exvalidate.Rules.In do
  @moduledoc """
  This module validate that the value or list of values are into the list
  """
  use Exvalidate.Rules.IRules

  def validating(%{"in" => list}, field, data) when is_list(list) do
    case is_into(list, Map.get(data, field)) do
      {:ok, true} ->
        {:ok, data}

      {:ok, false} ->
        {:error, "#{field} hasn't into the list."}

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _, _), do: {:error, "The rule 'in' is wrong."}

  @spec is_into(list, any) :: {:ok, boolean} | {:error, String.t()}

  defp is_into(list, value) when is_binary(value) or is_number(value) do
    if value in list do
      {:ok, true}
    else
      {:ok, false}
    end
  end

  defp is_into(list, value) when is_list(value) do
    {:ok, Enum.reduce_while(value, %{}, &is_in_list(&1, &2, list))}
  end

  defp is_into(_max, _value) do
    {:error, "The field has to be a String, number or list."}
  end

  @spec is_in_list(String.t(), map, list) :: {:cont, true} | {:halt, false}

  defp is_in_list(opt, _acc, list) do
    if opt in list do
      {:cont, true}
    else
      {:halt, false}
    end
  end
end
