defmodule Exvalidate.Rules.Mapping do
  @moduledoc """
  The mapping module serve for get the rule module. With this module we
  comprove the rules. If the rules doesn't exists, this module will return
  the tuple {:error, msg} and if the rule exists the module return the
  validate module.
  """

  @route "Elixir.Exvalidate.Rules."

  @spec get_module(String.t()) :: {:ok, module} | {:error, String.t()}

  def get_module(key) do
    {:ok, String.to_existing_atom(@route <> Macro.camelize(key))}
  rescue
    _ex -> 
      {:error, "The rule '#{key}' doesn't exists."}
  end
end
