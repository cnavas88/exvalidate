defmodule Exvalidate.Messages do
  @moduledoc """
  Module for get the string message
  """

  alias Exvalidate.Messages.Matrix

  def get({{rule, rule_opts}, error}, _data, field) do
    error
    |> Matrix.get_message()
    |> String.replace("%FIELD%", "#{field}")
    |> String.replace("%RULE_OPTS%", "#{inspect(rule_opts)}")
    |> String.replace("%RULE%", "#{rule}")
  end

  def get({rule, error}, data, field) do
    error
    |> Matrix.get_message()
    |> String.replace("%FIELD%", "#{field}")
    |> String.replace("%DATA%", "#{data}")
    |> String.replace("%RULE%", "#{rule}")
  end
end
