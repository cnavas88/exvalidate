defmodule Exvalidate.Rules.MaxLengthTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.MaxLength

  @validate_fn &MaxLength.validating/2

  describe "validating/3 max_length is not a number" do
    test "is a string" do
      rules = {:max_length, "6"}
      value = "Vegeta"

      result = @validate_fn.(rules, value)

      assert result == {:error, :max_length_rule_wrong}
    end
  end

  describe "validating/3 value is can't be evaluated" do
    test "is not a type valid." do
      rules = {:max_length, 6}

      value = %{
        "name" => "Vegeta"
      }

      result = @validate_fn.(rules, value)

      assert result == {:error, :max_length_value_type_wrong}
    end
  end

  describe "validating/3 max_length string." do
    test "string length is lower than maxlength field." do
      rules = {:max_length, 20}
      value = "Vegeta"

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "string length is equal than maxlength field." do
      rules = {:max_length, 3}
      value = "Boo"

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "string validation is wrong." do
      rules = {:max_length, 4}
      value = "Vegeta"

      result = @validate_fn.(rules, value)

      assert result == {:error, :max_length_greater_than_max}
    end
  end

  describe "validating/3 max_length list." do
    test "list length is equal max_length." do
      rules = {:max_length, 2}
      value = ["Vegeta", "Picolo"]

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "list legnth is lower than max length." do
      rules = {:max_length, 5}
      value = ["Vegeta", "Picolo", "Bulma"]

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "list validation is wrong." do
      rules = {:max_length, 1}
      value = ["Vegeta", "Bulma"]

      result = @validate_fn.(rules, value)

      assert result == {:error, :max_length_greater_than_max}
    end
  end

  describe "validating/3 max_length tuple." do
    test "tuple length is equal max_length." do
      rules = {:max_length, 2}
      value = {"Vegeta", "Picolo"}

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "tuple legnth is lower than max length." do
      rules = {:max_length, 5}
      value = {"Vegeta", "Picolo", "Bulma"}

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "tuple validation is wrong." do
      rules = {:max_length, 1}
      value = {"Vegeta", "Bulma"}

      result = @validate_fn.(rules, value)

      assert result == {:error, :max_length_greater_than_max}
    end
  end
end
