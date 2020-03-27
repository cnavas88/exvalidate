defmodule Exvalidate.Rules.TypeTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Type

  describe "Type is an atom." do
    test "Atom validation pass." do
      rules = {:type, :atom}
      value = :Saiyajin

      result = Type.validating(rules, value)

      assert result == {:ok, :Saiyajin}
    end

    test "Atom validation get wrong." do
      rules = {:type, :atom}
      value = 33

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end

    test "String validation pass." do
      rules = {:type, :atom}
      value = "Saiyajin"

      result = Type.validating(rules, value)

      assert result == {:ok, :Saiyajin}
    end
  end

  describe "Type is a string." do
    test "String validation pass." do
      rules = {:type, :string}
      value = "Saiyajin"

      result = Type.validating(rules, value)

      assert result == {:ok, "Saiyajin"}
    end

    test "String validation get wrong." do
      rules = {:type, :string}
      value = 33

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a list." do
    test "List validation pass." do
      rules = {:type, :list}
      value = ["Saiyajin", "Namek"]

      result = Type.validating(rules, value)

      assert result == {:ok, ["Saiyajin", "Namek"]}
    end

    test "List validation get wrong." do
      rules = {:type, :list}
      value = "Saiyajin"

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a map." do
    test "Map validation pass." do
      rules = {:type, :map}
      value = %{"Saiyajin" => "Vegetta"}

      result = Type.validating(rules, value)

      assert result == {:ok, %{"Saiyajin" => "Vegetta"}}
    end

    test "Map validation get wrong." do
      rules = {:type, :map}
      value = "Saiyajin"

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a tuple." do
    test "Tuple validation pass." do
      rules = {:type, :tuple}
      value = {"Saiyajin", "Namek"}

      result = Type.validating(rules, value)

      assert result == {:ok, {"Saiyajin", "Namek"}}
    end

    test "Tuple validation get wrong." do
      rules = {:type, :tuple}
      value = "Saiyajin"

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a boolean." do
    test "Boolean true validation pass." do
      rules = {:type, :boolean}
      value = true

      result = Type.validating(rules, value)

      assert result == {:ok, true}
    end

    test "Boolean false validation pass." do
      rules = {:type, :boolean}
      value = false

      result = Type.validating(rules, value)

      assert result == {:ok, false}
    end

    test "String 'true' validation pass and convert." do
      rules = {:type, :boolean}
      value = "true"

      result = Type.validating(rules, value)

      assert result == {:ok, true}
    end

    test "String 'false' validation pass and convert." do
      rules = {:type, :boolean}
      value = "false"

      result = Type.validating(rules, value)

      assert result == {:ok, false}
    end

    test "String 'TRUE' validation pass and convert." do
      rules = {:type, :boolean}
      value = "TRUE"

      result = Type.validating(rules, value)

      assert result == {:ok, true}
    end

    test "String 'FALSE' validation pass and convert." do
      rules = {:type, :boolean}
      value = "FALSE"

      result = Type.validating(rules, value)

      assert result == {:ok, false}
    end

    test "String '1' validation pass and convert." do
      rules = {:type, :boolean}
      value = "1"

      result = Type.validating(rules, value)

      assert result == {:ok, true}
    end

    test "String '0' validation pass and convert." do
      rules = {:type, :boolean}
      value = "0"

      result = Type.validating(rules, value)

      assert result == {:ok, false}
    end

    test "Other String validation wrong." do
      rules = {:type, :boolean}
      value = "kakarot"

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end

    test "Number 1 validation pass and convert." do
      rules = {:type, :boolean}
      value = 1

      result = Type.validating(rules, value)

      assert result == {:ok, true}
    end

    test "Number 0 validation pass and convert." do
      rules = {:type, :boolean}
      value = 0

      result = Type.validating(rules, value)

      assert result == {:ok, false}
    end

    test "Boolean validation get wrong." do
      rules = {:type, :boolean}
      value = %{}

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a :integer." do
    test "Integer validation pass." do
      rules = {:type, :integer}
      value = 3

      result = Type.validating(rules, value)

      assert result == {:ok, 3}
    end

    test "Integer validation get wrong." do
      rules = {:type, :integer}
      value = [3]

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end

    test "String validation pass." do
      rules = {:type, :integer}
      value = "3"

      result = Type.validating(rules, value)

      assert result == {:ok, 3}
    end

    test "String validation get wrong." do
      rules = {:type, :integer}
      value = "Three"

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a :float." do
    test "Float validation pass." do
      rules = {:type, :float}
      value = 3.5

      result = Type.validating(rules, value)

      assert result == {:ok, 3.5}
    end

    test "Float validation get wrong." do
      rules = {:type, :float}
      value = [3]

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end

    test "String validation pass." do
      rules = {:type, :float}
      value = "3.3"

      result = Type.validating(rules, value)

      assert result == {:ok, 3.3}
    end

    test "String validation get wrong." do
      rules = {:type, :float}
      value = "Three"

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a :number." do
    test "Integer validation pass." do
      rules = {:type, :number}
      value = 3

      result = Type.validating(rules, value)

      assert result == {:ok, 3}
    end

    test "Float validation pass." do
      rules = {:type, :number}
      value = 3.5

      result = Type.validating(rules, value)

      assert result == {:ok, 3.5}
    end

    test "String validation integer pass." do
      rules = {:type, :number}
      value = "3"

      result = Type.validating(rules, value)

      assert result == {:ok, 3}
    end

    test "String validation integer wrong." do
      rules = {:type, :number}
      value = "Three"

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end

    test "String validation float pass." do
      rules = {:type, :number}
      value = "3.3"

      result = Type.validating(rules, value)

      assert result == {:ok, 3.3}
    end

    test "String validation float wrong." do
      rules = {:type, :number}
      value = "Thr.ee"

      result = Type.validating(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end
end
