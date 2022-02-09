defmodule Ear.Parsers.IllegalTokenParser do
  @moduledoc false
  # Catch Parser if no other parser succeeded

  alias Ear.State

  def parse(state) do
    State.make_errors([{:error, state.lnb, "Illegal Token"}])
  end
end
#  SPDX-License-Identifier: Apache-2.0
