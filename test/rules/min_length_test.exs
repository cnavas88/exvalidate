defmodule Exvalidate.Rules.MinLengthTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.MinLength

  describe "validating/3 min_length is not a number" do
    test "is a string" do
      rules = {:min_length, "6"}
      value = "Vegeta"

      result = MinLength.validating(rules, value)

      assert result == {:error, :min_length_rule_wrong}
    end
  end

  describe "validating/3 value is can't be evaluated" do
    test "is not a type valid." do
      rules = {:min_length, 6}
      value = %{
        "name" => "Vegeta"
      }

      result = MinLength.validating(rules, value)

      assert result == {:error, :min_length_value_type_wrong}
    end
  end

  describe "validating/3 min_length string." do
    test "string length is more than minlength field." do
      rules = {:min_length, 2}
      value = "Vegeta"

      result = MinLength.validating(rules, value)

      assert result == {:ok, "Vegeta"}
    end

    test "string length is equal than minlength field." do
      rules = {:min_length, 3}
      value = "Boo"

      result = MinLength.validating(rules, value)

      assert result == {:ok, "Boo"}
    end

    test "string validation is wrong." do
      rules = {:min_length, 20}
      value = "Vegeta"

      result = MinLength.validating(rules, value)

      assert result == {:error, :min_length_lower_than_min}
    end
  end

  describe "validating/3 min_length list." do
    test "list length is equal min length." do
      rules = {:min_length, 2}
      value = ["Vegeta", "Picolo"]

      result = MinLength.validating(rules, value)

      assert result == {:ok, ["Vegeta", "Picolo"]}
    end

    test "list legnth is more than min length." do
      rules = {:min_length, 2}
      value = ["Vegeta", "Picolo", "Bulma"]

      result = MinLength.validating(rules, value)

      assert result == {:ok, ["Vegeta", "Picolo", "Bulma"]}
    end

    test "list validation is wrong." do
      rules = {:min_length, 20}
      value = ["Vegeta"]

      result = MinLength.validating(rules, value)

      assert result == {:error, :min_length_lower_than_min}
    end
  end

  describe "validating/3 min_length tuple." do
    test "tuple length is equal min_length." do
      rules = {:min_length, 2}
      value = {"Vegeta", "Picolo"}

      result = MinLength.validating(rules, value)

      assert result == {:ok, {"Vegeta", "Picolo"}}
    end

    test "tuple legnth is lower than min length." do
      rules = {:min_length, 5}
      value = {"Vegeta", "Picolo", "Bulma"}

      result = MinLength.validating(rules, value)

      assert result == {:ok, {"Vegeta", "Picolo", "Bulma"}}
    end

    test "tuple validation is wrong." do
      rules = {:min_length, 1}
      value = {"Vegeta", "Bulma"}

      result = MinLength.validating(rules, value)

      assert result == {:error, :min_length_lower_than_min}
    end
  end
end
