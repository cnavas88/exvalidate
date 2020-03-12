defmodule Exvalidate.Rules.IRules do
  @moduledoc """
  Interface pattern for the all rules
  """

  @callback validating(map, String.t(), map) :: {:ok, map}

  defmacro __using__(_) do
    quote do
      alias Exvalidate.Rules.IRules

      @behaviour IRules

      @impl IRules
      def validating(_, _, _) do
        raise "validating/3 Not implemented."
      end

      defoverridable [validating: 3]
    end
  end
end