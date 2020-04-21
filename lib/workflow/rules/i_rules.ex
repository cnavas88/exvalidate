defmodule Exvalidate.Rules.IRules do
  @moduledoc false

  @callback validating(tuple | atom, any) :: {:ok, any}

  defmacro __using__(_) do
    quote do
      alias Exvalidate.Rules.IRules

      @behaviour IRules

      @impl IRules
      @doc false
      def validating(_, _) do
        raise "validating/2 Not implemented."
      end

      defoverridable validating: 2
    end
  end
end
