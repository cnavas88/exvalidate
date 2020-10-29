defmodule Exvalidate.Rules.AcceptedTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Accepted

  @validate_key :accepted
  @validate_fn &Accepted.validating/2

  describe "validating/3. Not accepted" do
    test "with value is nil." do
      result = @validate_fn.(@validate_key, nil)

      assert result == {:error, :not_accepted}
    end

    test "with value is false." do
      result = @validate_fn.(@validate_key, false)

      assert result == {:error, :not_accepted}
    end

    test "with value is 'off'." do
      result = @validate_fn.(@validate_key, "off")

      assert result == {:error, :not_accepted}
    end

    test "with value is 0." do
      result = @validate_fn.(@validate_key, 0)

      assert result == {:error, :not_accepted}
    end

    test "with value is 'no'." do
      result = @validate_fn.(@validate_key, "no")

      assert result == {:error, :not_accepted}
    end
  end

  describe "validating/3. Accepted" do
    test "with value is true." do
      value = true

      result = @validate_fn.(@validate_key, value)

      assert result == {:ok, value}
    end

    test "with value is 'on'." do
      value = "on"

      result = @validate_fn.(@validate_key, value)

      assert result == {:ok, value}
    end

    test "with value is 1." do
      value = 1

      result = @validate_fn.(@validate_key, value)

      assert result == {:ok, value}
    end

    test "with value is 'yes'." do
      value = "yes"

      result = @validate_fn.(@validate_key, value)

      assert result == {:ok, value}
    end
  end
end
