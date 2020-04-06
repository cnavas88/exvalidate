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
  use Exvalidate.Rules.IRules

  @spec validating({:type, number}, any) ::
          {:ok, any}
          | {:error, :type_value_wrong}
          | {:error, :type_rule_wrong}
          | {:error, :type_value_is_not_supported}

  @doc """
  # Validate the atom
    if you want validate an atom you use the :atom. 
    For :atom validation you can send an atom or a binary (for the request plug)
    if send a binary the validation type :atom converts the binary to atom and
    return this value.

  ## Examples
    > validating({:type, :atom}, :saiyajin)
    {:ok, :saiyajin}

    > validating({:type, :atom}, "saiyajin")
    {:ok, :saiyajin}

  # Validate the string
    if you want validate an atom you use the :string. 
    For :string validation you can send an binary.

  ## Examples
    > validating({:type, :string}, "saiyajin")
    {:ok, "saiyajin"}


  For see examples go to the tests: test/rules/type_test.exs  
  """
  def validating({:type, type}, value) when is_atom(type) do
    case is_this_type(type, value) do
      {:ok, :valid} ->
        {:ok, value}

      {:ok, :not_valid} ->
        {:error, :type_value_wrong}

      # TODO - "#{field} must be type #{type}."

      {:ok, typed_value} ->
        {:ok, typed_value}

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _), do: {:error, :type_rule_wrong}
  # TODO - "The type rule must be an atom."

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
      "0" -> {:ok, false}
      "1" -> {:ok, true}
      "false" -> {:ok, false}
      "true" -> {:ok, true}
      _ -> {:ok, :not_valid}
    end
  end

  defp is_this_type(:boolean, 0), do: {:ok, false}
  defp is_this_type(:boolean, 1), do: {:ok, true}
  defp is_this_type(:boolean, _value), do: {:ok, :not_valid}

  defp is_this_type(:number, value) when is_number(value), do: {:ok, :valid}

  defp is_this_type(:number, value) when is_binary(value) do
    if String.contains?(value, ".") do
      is_this_type(:float, value)
    else
      is_this_type(:integer, value)
    end
  end

  defp is_this_type(:number, _value), do: {:ok, false}

  defp is_this_type(:integer, value) when is_integer(value), do: {:ok, :valid}

  defp is_this_type(:integer, value) when is_binary(value) do
    case Integer.parse(value) do
      {num, ""} -> {:ok, num}
      _ -> {:ok, :not_valid}
    end
  end

  defp is_this_type(:integer, _value), do: {:ok, :not_valid}

  defp is_this_type(:float, value) when is_float(value), do: {:ok, :valid}

  defp is_this_type(:float, value) when is_binary(value) do
    case Float.parse(value) do
      {num, ""} -> {:ok, num}
      _ -> {:ok, :not_valid}
    end
  end

  defp is_this_type(:float, _value), do: {:ok, :not_valid}

  defp is_this_type(_type, _value) do
    {:error, :type_value_is_not_supported}

    # TODO - "The field must be the next type: :atom, :string, :list, :map, :tuple, :number, :boolean, :integer, :float."
  end
end
