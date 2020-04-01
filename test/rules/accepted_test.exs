defmodule Exvalidate.Rules.AcceptedTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Accepted

  describe "validating/3. Not accepted" do
    test "with value is nil." do
      rules = :accepted
      value = nil

      result = Accepted.validating(rules, value)

      assert result == {:error, :not_accepted}
    end

    test "with value is false." do
      rules = :accepted
      value = false

      result = Accepted.validating(rules, value)

      assert result == {:error, :not_accepted}
    end

    test "with value is 'off'." do
      rules = :accepted
      value = "off"

      result = Accepted.validating(rules, value)

      assert result == {:error, :not_accepted}
    end

    test "with value is 0." do
      rules = :accepted
      value = 0

      result = Accepted.validating(rules, value)

      assert result == {:error, :not_accepted}
    end

    test "with value is 'no'." do
      rules = :accepted
      value = "no"

      result = Accepted.validating(rules, value)

      assert result == {:error, :not_accepted}
    end

    test "Error passing first parameter." do
      rules = :accepte
      value = "Nooop"

      result = Accepted.validating(rules, value)

      assert result == {:error, :accepted_rule_wrong}
    end
  end

  describe "validating/3. Accepted" do
    test "with value is true." do
      rules = :accepted
      value = true

      result = Accepted.validating(rules, value)

      assert result == {:ok, true}
    end

    test "with value is 'on'." do
      rules = :accepted
      value = "on"

      result = Accepted.validating(rules, value)

      assert result == {:ok, "on"}
    end

    test "with value is 1." do
      rules = :accepted
      value = 1

      result = Accepted.validating(rules, value)

      assert result == {:ok, 1}
    end

    test "with value is 'yes'." do
      rules = :accepted
      value = "yes"

      result = Accepted.validating(rules, value)

      assert result == {:ok, "yes"}
    end
  end
end
