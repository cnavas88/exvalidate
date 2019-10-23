defmodule Exvalidate.Rules.Type do
  @moduledoc """
  This validation check the type of variable. The checked types are the next: 
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

  @doc """
  # Validate the atom
    if you want validate an atom you use the :atom. 
    For :atom validation you can send an atom or a binary (for the request plug)
    if send a binary the validation type :atom converts the binary to atom and
    return this value.

  ## Examples
    > validating(%{"type" => :atom}, "name", %{"name" => :saiyajin})
    {:ok, %{"name" => :saiyajin}}

    > validating(%{"type" => :atom}, "name", %{"name" => "saiyajin"})
    {:ok, %{"name" => :saiyajin}}

  # Validate the string
    if you want validate an atom you use the :string. 
    For :string validation you can send an binary.

  ## Examples
    > validating(%{"type" => :string}, "name", %{"name" => "saiyajin"})
    {:ok, %{"name" => "saiyajin"}}
  """
  def validating(%{"type" => type}, field, data)
      when is_atom(type) do
    case is_this_type(type, Map.get(data, field)) do
      {:ok, :valid} ->
        {:ok, data}

      {:ok, :not_valid} ->
        {:error, "#{field} must be type #{type}."}

      {:ok, value} ->
        {:ok, Map.put(data, field, value)}

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _, _), do: {:error, "The type rule must be an atom."}

  @spec is_this_type(atom, any) :: {:ok, boolean} | {:error, String.t()}

  defp is_this_type(:atom, value) when is_atom(value), do: {:ok, :valid}

  defp is_this_type(:atom, value) when is_binary(value) do
    {:ok, String.to_atom(value)}
  end

  defp is_this_type(:atom, _value), do: {:ok, :not_valid}

  defp is_this_type(:string, value) when is_binary(value), do: {:ok, :valid}
  defp is_this_type(:string, _value), do: {:ok, :not_valid}

  defp is_this_type(:list, value) when is_list(value), do: {:ok, :valid}
  defp is_this_type(:list, _value), do: {:ok, :not_valid}

  defp is_this_type(:map, value) when is_map(value), do: {:ok, :valid}
  defp is_this_type(:map, _value), do: {:ok, :not_valid}

  defp is_this_type(:tuple, value) when is_tuple(value), do: {:ok, :valid}
  defp is_this_type(:tuple, _value), do: {:ok, :not_valid}

  defp is_this_type(:boolean, value) when is_boolean(value), do: {:ok, :valid}
  defp is_this_type(:boolean, value) when is_binary(value) do
    case String.downcase(value) do
      "0"     -> {:ok, false}
      "1"     -> {:ok, true}
      "false" -> {:ok, false}
      "true"  -> {:ok, true}
      _       -> {:ok, :not_valid}
    end
  end
  defp is_this_type(:boolean, value) when is_integer(value) do
    case value do
      0 -> {:ok, false}
      1 -> {:ok, true}
      _ -> {:ok, :not_valid}
    end
  end
  defp is_this_type(:boolean, _value), do: {:ok, :not_valid}

  # defp is_this_type(:number, value) when is_number(value), do: {:ok, true}
  # defp is_this_type(:number, _value), do: {:ok, false}

  # defp is_this_type(:integer, value) when is_integer(value), do: {:ok, true}
  # defp is_this_type(:integer, _value), do: {:ok, false}

  # defp is_this_type(:float, value) when is_float(value), do: {:ok, true}
  # defp is_this_type(:float, _value), do: {:ok, false}

  defp is_this_type(_min, _value) do
    {:error, "The field must be the next type: :atom, :string, :list, :map, 
    :tuple, :number, :boolean, :integer, :float."}
  end
end
