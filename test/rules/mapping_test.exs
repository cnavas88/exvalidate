defmodule Exvalidate.Rules.MappingTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Mapping

  describe "get_module/1." do
    test "The key 'required' exists." do
      result = Mapping.get_module("required")

      assert result == {:ok, Exvalidate.Rules.Required}
    end

    test "The key 'default' exists." do
      result = Mapping.get_module("default")

      assert result == {:ok, Exvalidate.Rules.Default}
    end

    test "The key 'min_length' exists." do
      result = Mapping.get_module("min_length")

      assert result == {:ok, Exvalidate.Rules.MinLength}
    end

    test "The key 'max_length' exists." do
      result = Mapping.get_module("max_length")

      assert result == {:ok, Exvalidate.Rules.MaxLength}
    end

    test "The key 'in' exists." do
      result = Mapping.get_module("in")

      assert result == {:ok, Exvalidate.Rules.In}
    end

    test "The key 'numeric' exists." do
      result = Mapping.get_module("numeric")

      assert result == {:ok, Exvalidate.Rules.Numeric}
    end

    test "The key doesn't exists." do
      result = Mapping.get_module("noooooooop")

      assert result == {:error, "The rule 'noooooooop' doesn't exists."}
    end
  end
end
