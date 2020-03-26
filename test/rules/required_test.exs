defmodule Exvalidate.Rules.RequiredTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Required

  describe "validating/3 return ok." do
    test "value is integer." do
      rule = :required
      value = 1324

      result = Required.validating(rule, value)

      assert result == {:ok, value}
    end

    test "value is string." do
      rule = :required
      value = "1234"

      result = Required.validating(rule, value)

      assert result == {:ok, value}
    end
  end

  describe "validating/3 return error." do
    test "value is nil." do
      rule = :required
      value = nil

      result = Required.validating(rule, value)

      assert result == {:error, :required_value_wrong}
    end

    test "value is empty string." do
      rule = :required
      value = ""

      result = Required.validating(rule, value)

      assert result == {:error, :required_value_wrong}
    end

    test "rule required wrong." do
      rule = :requiredd
      value = ""

      result = Required.validating(rule, value)

      assert result == {:error, :required_rule_wrong}
    end
  end
end
