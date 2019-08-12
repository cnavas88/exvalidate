defmodule Exvalidate.Rules.Mapping do
  @moduledoc """

  """

  @mapping %{
    "required" => Exvalidate.Rules.Required
  }

  def get_mapping, do: @mapping

  def get_module(key) do
    case Map.get(@mapping, key) do
      nil    ->
        {:error, "The rule '#{key}' doesn't exists."}

      module ->
        {:ok, module}
    end
  end
end
