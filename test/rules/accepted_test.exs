defmodule Exvalidate.Rules.AcceptedTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Accepted

  describe "validating/3. Not accepted" do
    test "with value is nil." do
      result = Accepted.validating(:accepted, nil)

      assert result == {:error, :not_accepted}
    end

    test "with value is false." do
      result = Accepted.validating(:accepted, false)

      assert result == {:error, :not_accepted}
    end

    test "with value is 'off'." do
      result = Accepted.validating(:accepted, "off")

      assert result == {:error, :not_accepted}
    end

    test "with value is 0." do
      result = Accepted.validating(:accepted, 0)

      assert result == {:error, :not_accepted}
    end

    test "with value is 'no'." do
      result = Accepted.validating(:accepted, "no")

      assert result == {:error, :not_accepted}
    end
  end

  describe "validating/3. Accepted" do
    test "with value is true." do
      value = true

      result = Accepted.validating(:accepted, value)

      assert result == {:ok, value}
    end

    test "with value is 'on'." do
      value = "on"

      result = Accepted.validating(:accepted, value)

      assert result == {:ok, value}
    end

    test "with value is 1." do
      value = 1

      result = Accepted.validating(:accepted, value)

      assert result == {:ok, value}
    end

    test "with value is 'yes'." do
      value = "yes"

      result = Accepted.validating(:accepted, value)

      assert result == {:ok, value}
    end
  end
end
