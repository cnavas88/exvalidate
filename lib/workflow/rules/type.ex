defmodule Exvalidate.Rules.Type do
  @moduledoc """
  :atom, :boolean, :number and :string,

  TODO - FALTARIA EL IS_INTEGER Y IS_FLOAT Y IS_BOOLEAN
  """

  @spec validating(map, String.t(), map) :: {:ok, map} | {:error, String.t()}

  def validating(%{"type" => type}, field, data)
      when is_atom(type) do
    case is_this_type(type, Map.get(data, field)) do
      {:ok, true} ->
        {:ok, data}

      {:ok, false} ->
        {:error, "#{field} must be type #{type}."}

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _, _),
    do: {:error, "The rules type must be the next type: :atom, :string, :list, :map, :tuple."}

  @spec is_this_type(atom, any) :: {:ok, boolean} | {:error, String.t()}

  defp is_this_type(:atom, value) when is_atom(value), do: {:ok, true}
  defp is_this_type(:atom, value), do: {:ok, false}

  defp is_this_type(:string, value) when is_binary(value), do: {:ok, true}
  defp is_this_type(:string, value), do: {:ok, false}

  defp is_this_type(:list, value) when is_list(value), do: {:ok, true}
  defp is_this_type(:list, value), do: {:ok, false}

  defp is_this_type(:map, value) when is_map(value), do: {:ok, true}
  defp is_this_type(:map, value), do: {:ok, false}

  defp is_this_type(:tuple, value) when is_tuple(value), do: {:ok, true}
  defp is_this_type(:tuple, value), do: {:ok, false}

  defp is_this_type(_min, _value) do
    {:error, "The field has to be a String or list."}
  end
end
