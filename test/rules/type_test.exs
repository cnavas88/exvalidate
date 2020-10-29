defmodule Exvalidate.Rules.TypeTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Type

  @validate_fn &Type.validating/2

  describe "Type is an atom." do
    test "Atom validation pass." do
      rules = {:type, :atom}
      value = :Saiyajin

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "Atom validation get wrong." do
      rules = {:type, :atom}
      value = 33

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end

    test "String validation pass." do
      rules = {:type, :atom}
      value = "Saiyajin"

      result = @validate_fn.(rules, value)

      assert result == {:ok, :Saiyajin}
    end
  end

  describe "Type is a string." do
    test "String validation pass." do
      rules = {:type, :string}
      value = "Saiyajin"

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "String validation get wrong." do
      rules = {:type, :string}
      value = 33

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a list." do
    test "List validation pass." do
      rules = {:type, :list}
      value = ["Saiyajin", "Namek"]

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "List validation get wrong." do
      rules = {:type, :list}
      value = "Saiyajin"

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a map." do
    test "Map validation pass." do
      rules = {:type, :map}
      value = %{"Saiyajin" => "Vegetta"}

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "Map validation get wrong." do
      rules = {:type, :map}
      value = "Saiyajin"

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a tuple." do
    test "Tuple validation pass." do
      rules = {:type, :tuple}
      value = {"Saiyajin", "Namek"}

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "Tuple validation get wrong." do
      rules = {:type, :tuple}
      value = "Saiyajin"

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a boolean." do
    test "Boolean true validation pass." do
      rules = {:type, :boolean}
      value = true

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "Boolean false validation pass." do
      rules = {:type, :boolean}
      value = false

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "String 'true' validation pass and convert." do
      rules = {:type, :boolean}
      value = "true"

      result = @validate_fn.(rules, value)

      assert result == {:ok, true}
    end

    test "String 'false' validation pass and convert." do
      rules = {:type, :boolean}
      value = "false"

      result = @validate_fn.(rules, value)

      assert result == {:ok, false}
    end

    test "String 'TRUE' validation pass and convert." do
      rules = {:type, :boolean}
      value = "TRUE"

      result = @validate_fn.(rules, value)

      assert result == {:ok, true}
    end

    test "String 'FALSE' validation pass and convert." do
      rules = {:type, :boolean}
      value = "FALSE"

      result = @validate_fn.(rules, value)

      assert result == {:ok, false}
    end

    test "String '1' validation pass and convert." do
      rules = {:type, :boolean}
      value = "1"

      result = @validate_fn.(rules, value)

      assert result == {:ok, true}
    end

    test "String '0' validation pass and convert." do
      rules = {:type, :boolean}
      value = "0"

      result = @validate_fn.(rules, value)

      assert result == {:ok, false}
    end

    test "Other String validation wrong." do
      rules = {:type, :boolean}
      value = "kakarot"

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end

    test "Number 1 validation pass and convert." do
      rules = {:type, :boolean}
      value = 1

      result = @validate_fn.(rules, value)

      assert result == {:ok, true}
    end

    test "Number 0 validation pass and convert." do
      rules = {:type, :boolean}
      value = 0

      result = @validate_fn.(rules, value)

      assert result == {:ok, false}
    end

    test "Boolean validation get wrong." do
      rules = {:type, :boolean}
      value = %{}

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a :integer." do
    test "Integer validation pass." do
      rules = {:type, :integer}
      value = 3

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "Integer validation get wrong." do
      rules = {:type, :integer}
      value = [3]

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end

    test "String validation pass." do
      rules = {:type, :integer}
      value = "3"

      result = @validate_fn.(rules, value)

      assert result == {:ok, 3}
    end

    test "String validation get wrong." do
      rules = {:type, :integer}
      value = "Three"

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a :float." do
    test "Float validation pass." do
      rules = {:type, :float}
      value = 3.5

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "Float validation get wrong." do
      rules = {:type, :float}
      value = [3]

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end

    test "String validation pass." do
      rules = {:type, :float}
      value = "3.3"

      result = @validate_fn.(rules, value)

      assert result == {:ok, 3.3}
    end

    test "String validation get wrong." do
      rules = {:type, :float}
      value = "Three"

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end

  describe "Type is a :number." do
    test "Integer validation pass." do
      rules = {:type, :number}
      value = 3

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "Float validation pass." do
      rules = {:type, :number}
      value = 3.5

      result = @validate_fn.(rules, value)

      assert result == {:ok, value}
    end

    test "String validation integer pass." do
      rules = {:type, :number}
      value = "3"

      result = @validate_fn.(rules, value)

      assert result == {:ok, 3}
    end

    test "String validation integer wrong." do
      rules = {:type, :number}
      value = "Three"

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end

    test "String validation float pass." do
      rules = {:type, :number}
      value = "3.3"

      result = @validate_fn.(rules, value)

      assert result == {:ok, 3.3}
    end

    test "String validation float wrong." do
      rules = {:type, :number}
      value = "Thr.ee"

      result = @validate_fn.(rules, value)

      assert result == {:error, :type_value_wrong}
    end
  end
end
