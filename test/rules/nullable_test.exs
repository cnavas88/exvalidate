defmodule Exvalidate.Rules.NullableTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Nullable

  @validate_key :nullable
  @validate_fn &Nullable.validating/2

  describe "validating/3. Nullable" do
    test "with value is nil." do
      value = nil

      result = @validate_fn.(@validate_key, value)

      assert result == {:ok, value}
    end

    test "with value is empty string." do
      value = ""

      result = @validate_fn.(@validate_key, value)

      assert result == {:ok, value}
    end

    test "with value is a full string." do
      value = "krilin"

      result = @validate_fn.(@validate_key, value)

      assert result == {:error, :not_nullable}
    end

    test "with value is a number." do
      value = 0

      result = @validate_fn.(@validate_key, value)

      assert result == {:error, :not_nullable}
    end

    test "with rule is wrong." do
      rules = :goku
      value = "picolo"

      result = @validate_fn.(rules, value)

      assert result == {:error, :nullable_rule_wrong}
    end
  end
end
