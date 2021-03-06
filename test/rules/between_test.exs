defmodule Exvalidate.Rules.BetweenTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Between

  @validate_fn &Between.validating/2

  describe "validating/3 between is not a number" do
    test "is a string" do
      rules = {:between, {"6", "10"}}
      value = "Vegeta"

      result = @validate_fn.(rules, value)

      assert result == {:error, :between_rule_wrong}
    end
  end

  describe "validating/3 value is can't be evaluated" do
    test "is not a type valid." do
      rules = {:between, {6, 10}}

      value = %{
        "name" => "Vegeta"
      }

      result = @validate_fn.(rules, value)

      assert result == {:error, :between_value_invalid}
    end
  end

  describe "validating/3 string." do
    test "string length is between min and max." do
      rules = {:between, {4, 20}}
      value = "Vegeta"

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "string length is not between min and max." do
      rules = {:between, {3, 5}}
      value = "Vegeta"

      result = @validate_fn.(rules, value)

      assert result == {:error, :not_between_min_max}
    end
  end

  describe "validating/3 between list." do
    test "list length is between min and max." do
      rules = {:between, {4, 20}}
      value = ["Vegeta", "Goku", "Picolo", "Krilin"]

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "list length is not between min and max." do
      rules = {:between, {3, 5}}
      value = ["Vegeta", "Krilin"]

      result = @validate_fn.(rules, value)

      assert result == {:error, :not_between_min_max}
    end
  end

  describe "validating/3 between tuple." do
    test "tuple length is between min and max." do
      rules = {:between, {4, 20}}
      value = {"Vegeta", "Goku", "Picolo", "Krilin"}

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "tuple length is not between min and max." do
      rules = {:between, {3, 5}}
      value = {"Vegeta", "Krilin"}

      result = @validate_fn.(rules, value)

      assert result == {:error, :not_between_min_max}
    end
  end

  describe "validating/3 between number." do
    test "number is between min and max." do
      rules = {:between, {4, 20}}
      value = 7

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "number is not between min and max." do
      rules = {:between, {3, 5}}
      value = 35

      result = @validate_fn.(rules, value)

      assert result == {:error, :not_between_min_max}
    end
  end
end
