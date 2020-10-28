defmodule Exvalidate.Rules.NullableTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Nullable

  describe "validating/3. Nullable" do
    test "with value is nil." do
      rules = :nullable
      value = nil

      result = Nullable.validating(rules, value)

      assert result == {:ok, nil}
    end

    test "with value is empty string." do
      rules = :nullable
      value = ""

      result = Nullable.validating(rules, value)

      assert result == {:ok, ""}
    end

    test "with value is a full string." do
      rules = :nullable
      value = "krilin"

      result = Nullable.validating(rules, value)

      assert result == {:error, :not_nullable}
    end

    test "with value is a number." do
      rules = :nullable
      value = 0

      result = Nullable.validating(rules, value)

      assert result == {:error, :not_nullable}
    end

    test "with rule is wrong." do
      rules = :goku
      value = "picolo"

      result = Nullable.validating(rules, value)

      assert result == {:error, :nullable_rule_wrong}
    end
  end

end
