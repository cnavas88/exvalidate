defmodule Exvalidate.Rules.Mapping do
  @moduledoc """
  The mapping module serve for get the rule module. With this module we
  comprove the rules. If the rules doesn't exists, this module will return
  the tuple {:error, msg} and if the rule exists the module return the
  validate module.
  """

  # @mapping %{
  #   "required" => Exvalidate.Rules.Required,
  #   "default" => Exvalidate.Rules.Default,
  #   "min_length" => Exvalidate.Rules.MinLength,
  #   "max_length" => Exvalidate.Rules.MaxLength,
  #   "in" => Exvalidate.Rules.In,
  #   "numeric" => Exvalidate.Rules.Numeric
  # }

  @route "Elixir.Exvalidate.Rules."

  # @spec get_mapping :: map

  # def get_mapping, do: @mapping

  @spec get_module(String.t()) :: {:ok, module} | {:error, String.t()}

  def get_module(key) do
    {:ok, String.to_existing_atom(@route <> Macro.camelize(key))}
  rescue
    _ex -> {:error, "The rule '#{key}' doesn't exists."}
    # case Map.get(@mapping, key) do
    #   nil ->
    #     {:error, "The rule '#{key}' doesn't exists."}

    #   module ->
    #     {:ok, module}
    # end
  end
end
