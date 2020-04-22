defmodule Exvalidate do
  @moduledoc """
  Enter point for validate data structure.

  If you want to validate a data set you first have to take into account 
  the following important points:

  1 - This dependence is based on a schema-data system in which two data 
  structures are received, one called schema and another called data which 
  have to be related in some way.

  2 - The creation of a good schema is essential for the validation of data, 
  remember that the library validates the data in a sequential way, therefore 
  it is the schema that decides which is validated first and which rule 
  is validated first. If it fails, it will always give the corresponding error.

  The schema should be a keyw ord list in the following way, examples:

  ```
  @schema [
    id: [:required]
  ]
  ```

  another example:

    ```
  @schema [
    id: [:required, length: 16],
    name: [type: string, max_legnth: 24]
  ]
  ```

  The last example first validate the id data with the schema [:required, lenght: 16],
  if the required fault, return this error an not continue with the validation.

  the rules that are available right now are:

  - :accepted.
  - between: {min, max}, where min and max are integers.
  - default: default_value.
  - :email.
  - in: [].
  - length: equal_length, where equal_length is a integer.
  - max_length: max, where max is a integer.
  - min_length: min, where min is a integer.
  - :required
  - type: type, where type can be: :atom, :string, :list, :map, :tuple, :number, :integer, :float

  3 - the data should always be a map. At the moment nothing else is accepted, 
  if you want to validate a specific data I recommend you to call directly 
  to the rules, each one of them has its documentation with some example of 
  operation and its corresponding tests.

  Example of data:

  ```
  %{
    "id" => 12_345,
    "name" => "picolo"
  }
  ```

  4- The entry point is a macro called validate, which we will use as follows:
  ```
  use Exvalidate

  ```

  and the last:

  ```
  validate(data, schema)
  ```

  """

  alias Exvalidate.Messages

  defmacro __using__(_) do
    quote do
      alias Exvalidate.Validate

      @validate_fn &Validate.rules/2

      @doc false
      def validate(data, schema, validate_fn \\ @validate_fn) do
        Exvalidate.run_validate(data, schema, validate_fn)
      end
    end
  end

  @spec run_validate(map(), list(), function()) ::
          {:ok, map()} | {:error, String.t()}

  @doc false
  def run_validate(data, schema, validate_fn) do
    with :ok <- validate_allowed_params(data, schema),
         {:ok, new_data} <- validate_schema(data, schema, validate_fn) do
      {:ok, new_data}
    else
      {:error, msg} -> {:error, msg}
    end
  end

  defp validate_allowed_params(data, schema) do
    case Keyword.keys(schema) -- keys_to_atom(Map.keys(data)) do
      [] ->
        :ok

      [field | _rest] ->
        {:error, "#{field} is not allowed."}
    end
  end

  defp keys_to_atom(keys) do
    Enum.map(keys, &String.to_atom(&1))
  end

  defp validate_schema(data, schema, validate_fn) do
    Enum.reduce_while(schema, {:ok, data}, &validating(&1, &2, validate_fn))
  end

  defp validating({key, rules}, {:ok, data}, validate_fn) do
    parse_key = Atom.to_string(key)
    rule_data = Map.get(data, parse_key)

    case validate_fn.(rules, rule_data) do
      {:ok, data_validate} ->
        modified_data = Map.put(data, parse_key, data_validate)
        {:cont, {:ok, modified_data}}

      {:error, error} ->
        {:halt, {:error, Messages.get(error, rule_data, key)}}
    end
  end
end
