defmodule Exvalidate.Rules.LengthTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Length

  describe "validating/3 length is not a number" do
    test "is a string" do
      rules = {:length, "6"}
      value = "Vegeta"

      result = Length.validating(rules, value)

      assert result == {:error, :rule_length_not_integer}
    end
  end

  describe "validating/3 length." do
    test "list length is equal than length." do
      rules = {:length, 2}
      value = ["Vegeta", "Picolo"]

      result = Length.validating(rules, value)

      assert result == {:ok, ["Vegeta", "Picolo"]}
    end

    test "list length is not equal than length." do
      rules = {:length, 5}
      value = ["Vegeta", "Picolo", "Bulma"]

      result = Length.validating(rules, value)

      assert result == {:error, :length_not_equal}
    end

    test "string validation is equal than length." do
      rules = {:length, 6}
      value = "Vegeta"

      result = Length.validating(rules, value)

      assert result == {:ok, "Vegeta"}
    end

    test "string validation is not equal than length." do
      rules = {:length, 1}
      value = "Vegeta"

      result = Length.validating(rules, value)

      assert result == {:error, :length_not_equal}
    end

    test "tuple validation is equal than length." do
      rules = {:length, 3}
      value = {"Vegeta", "Piccolo", "Krilin"}

      result = Length.validating(rules, value)

      assert result == {:ok, {"Vegeta", "Piccolo", "Krilin"}}
    end

    test "tuple validation is not equal than length." do
      rules = {:length, 3}
      value = {"Vegeta"}

      result = Length.validating(rules, value)

      assert result == {:error, :length_not_equal}
    end

    test "Value is not a string or list." do
      rules = {:length, 6}
      value = 6

      result = Length.validating(rules, value)

      assert result == {:error, :length_value_type_wrong}
    end
  end
end
