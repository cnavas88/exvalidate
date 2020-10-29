defmodule Exvalidate.Rules.LengthTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Length

  @validate_fn &Length.validating/2

  describe "validating/3 length is not a number" do
    test "is a string" do
      rules = {:length, "6"}
      value = "Vegeta"

      result = @validate_fn.(rules, value)

      assert result == {:error, :length_rule_wrong}
    end
  end

  describe "validating/3 length." do
    test "list length is equal than length." do
      rules = {:length, 2}
      value = ["Vegeta", "Picolo"]

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "list length is not equal than length." do
      rules = {:length, 5}
      value = ["Vegeta", "Picolo", "Bulma"]

      result = @validate_fn.(rules, value)

      assert result == {:error, :length_not_equal}
    end

    test "string validation is equal than length." do
      rules = {:length, 6}
      value = "Vegeta"

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "string validation is not equal than length." do
      rules = {:length, 1}
      value = "Vegeta"

      result = @validate_fn.(rules, value)

      assert result == {:error, :length_not_equal}
    end

    test "tuple validation is equal than length." do
      rules = {:length, 3}
      value = {"Vegeta", "Piccolo", "Krilin"}

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "tuple validation is not equal than length." do
      rules = {:length, 3}
      value = {"Vegeta"}

      result = @validate_fn.(rules, value)

      assert result == {:error, :length_not_equal}
    end

    test "Value is not a string or list." do
      rules = {:length, 6}
      value = 6

      result = @validate_fn.(rules, value)

      assert result == {:error, :length_value_type_wrong}
    end
  end
end
