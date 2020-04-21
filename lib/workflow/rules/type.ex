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
  - :atom => :vegeta, :picolo
  - :boolean => 

  ### Examples atom
  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :atom}, :Saiyajin)
  {:ok, :Saiyajin}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :atom}, 33)
  {:error, :type_value_wrong}
  ```

  ### Examples string
  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :string}, "Saiyajin")
  {:ok, "Boo"}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :string}, "Saiyajin")
  {:error, :type_value_wrong}
  ```

  ### Examples list
  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :list}, ["Saiyajin", "Namek"])
  {:ok, ["Saiyajin", "Namek"]}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :list}, "Saiyajin")
  {:error, :type_value_wrong}
  ```

  ### Examples map
  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :map}, %{"Saiyajin" => "Vegetta"})
  {:ok, %{"Saiyajin" => "Vegetta"}}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :map}, "Saiyajin")
  {:error, :type_value_wrong}
  ```

  ### Examples tuple
  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :tuple}, {"Saiyajin", "Namek"})
  {:ok, {"Saiyajin", "Namek"}}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :tuple}, "Saiyajin")
  {:error, :type_value_wrong}
  ```

  ### Examples number
  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :number}, 3)
  {:ok, 3}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :number}, 3.3)
  {:ok, 3.3}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :number}, "3")
  {:ok, 3}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :number}, "3.3")
  {:ok, 3.3}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :number}, "Thr.ee")
  {:error, :type_value_wrong}
  ```

  ### Examples float
  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :float}, 3.3)
  {:ok, 3.3}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :float}, "3.3")
  {:ok, 3.3}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :float}, "Vegeta")
  {:error, :type_value_wrong}
  ```

  ### Examples integer
  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :integer}, 3)
  {:ok, 3}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :integer}, "3")
  {:ok, 3}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :integer}, "Vegeta")
  {:error, :type_value_wrong}
  ```

  ### Examples boolean
  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :boolean}, true)
  {:ok, true}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :boolean}, false)
  {:ok, false}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :boolean}, "true")
  {:ok, true}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :boolean}, "false")
  {:ok, false}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :boolean}, "TRUE")
  {:ok, true}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :boolean}, "FALSE")
  {:ok, false}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :boolean}, "1")
  {:ok, true}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :boolean}, "0")
  {:ok, false}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :boolean}, 1)
  {:ok, true}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :boolean}, 0)
  {:ok, false}
  ```

  ```
  iex(3)> Exvalidate.Rules.Type.validating({:type, :boolean}, "Vegeta")
  {:error, :type_value_wrong}
  ```

  The :number type includes the types :float and :integer.
  """
  use Exvalidate.Rules.IRules

  def validating({:type, type}, value) when is_atom(type) do
    case is_this_type(type, value) do
      {:ok, :valid} ->
        {:ok, value}

      {:ok, :not_valid} ->
        {:error, :type_value_wrong}

      {:ok, typed_value} ->
        {:ok, typed_value}

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _), do: {:error, :type_rule_wrong}

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
  end
end
