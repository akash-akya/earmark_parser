defmodule Ear.State do
  @moduledoc ~S"""
  The global parse state (replaces Context for most purposes)
  """

  alias Ear.{Line, LineScanner, Options}

  defstruct ast: [], # Will become a list of Ast tuples
    lnb: 0,
    input: [],
    messages: MapSet.new,
    options: %Options{},
    token: nil # Ear.Line.*


  def new(input, options) do
    %__MODULE__{
      input: input,
      options: options} |> make_token
  end

  def make_errors(messages \\ []) do
    {:error, MapSet.new(messages)}
  end

  def make_token(state)
  def make_token(%{input: []}=state) do
    %{state|token: nil}
  end
  def make_token(%{input: [h|t], lnb: lnb}=state) do
    token = LineScanner.type_of(h, state.options, false)
    %{state|input: t, lnb: lnb + 1, token: token}
  end

  def result(state)
  def result(%__MODULE__{ast: ast, messages: messages}) do
    {_status(messages), ast, Enum.sort(messages)}
  end

  defp _error?(message)
  defp _error?({:warning, _, _}), do: false
  defp _error?(_), do: true

  defp _status(messages) do
    if Enum.any?(messages, &_error?/1) do
      :error
    else
      :ok
    end
  end

end
# SPDX-License-Identifier: Apache-2.0
