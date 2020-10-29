defmodule Exvalidate.Rules.RequiredTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Required

  @validate_key :required
  @validate_fn &Required.validating/2

  describe "validating/3 return ok." do
    test "value is integer." do
      value = 1324

      result = @validate_fn.(@validate_key, value)

      assert result == {:ok, value}
    end

    test "value is string." do
      value = "1234"

      result = @validate_fn.(@validate_key, value)

      assert result == {:ok, value}
    end
  end

  describe "validating/3 return error." do
    test "value is nil." do
      value = nil

      result = @validate_fn.(@validate_key, value)

      assert result == {:error, :required_value_wrong}
    end

    test "value is empty string." do
      value = ""

      result = @validate_fn.(@validate_key, value)

      assert result == {:error, :required_value_wrong}
    end

    test "rule required wrong." do
      rule = :requiredd
      value = ""

      result = @validate_fn.(rule, value)

      assert result == {:error, :required_rule_wrong}
    end
  end
end
