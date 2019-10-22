defmodule Exvalidate.Rules.Type do
  @moduledoc """
  This validation check the type of variable. The checked types are the next:
  - :atom => :name, :address, :language, 
  - :string => "name", "address", "language", 
  - :list => ["name", "address", "language"], 
  - :map => %{name: "Vegeta", address: "Vegeta planet"}, 
  - :tuple => {:name, "Vegeta"}, 
  - :number => 23, 2.3, 4, 0.9, -0.9, -4, 
  - :integer => 23, 4, -4, 
  - :float => 2.3, 0.9, -0.9.

  The :number type includes the types :float and :integer.
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

  def validating(_, _, _), do: {:error, "The type rule must be an atom."}

  @spec is_this_type(atom, any) :: {:ok, boolean} | {:error, String.t()}

  defp is_this_type(:atom, value) when is_atom(value), do: {:ok, true}
  defp is_this_type(:atom, _value), do: {:ok, false}

  defp is_this_type(:string, value) when is_binary(value), do: {:ok, true}
  defp is_this_type(:string, _value), do: {:ok, false}

  defp is_this_type(:list, value) when is_list(value), do: {:ok, true}
  defp is_this_type(:list, _value), do: {:ok, false}

  defp is_this_type(:map, value) when is_map(value), do: {:ok, true}
  defp is_this_type(:map, _value), do: {:ok, false}

  defp is_this_type(:tuple, value) when is_tuple(value), do: {:ok, true}
  defp is_this_type(:tuple, _value), do: {:ok, false}

  defp is_this_type(:boolean, value) when is_boolean(value), do: {:ok, true}
  defp is_this_type(:boolean, _value), do: {:ok, false}

  defp is_this_type(:number, value) when is_number(value), do: {:ok, true}
  defp is_this_type(:number, _value), do: {:ok, false}

  defp is_this_type(:integer, value) when is_integer(value), do: {:ok, true}
  defp is_this_type(:integer, _value), do: {:ok, false}

  defp is_this_type(:float, value) when is_float(value), do: {:ok, true}
  defp is_this_type(:float, _value), do: {:ok, false}

  defp is_this_type(_min, _value) do
    {:error, "The field must be the next type: :atom, :string, :list, :map, 
    :tuple, :number, :boolean, :integer, :float."}
  end
end