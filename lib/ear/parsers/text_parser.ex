defmodule Ear.Parsers.TextParser do
  @moduledoc false

  alias Ear.{Ast, Line, State}

  def parse(state)
  def parse(%{token: %Line.Text{line: line}}=state) do
    {:ok, _add_para(state, line)}
  end
  def parse(_), do: State.make_errors

  defp _add_para(%{ast: ast}=state, line) do
    ast_ = _add_text(line, ast)
    %{state | ast: ast_} |> State.make_token()
  end

  defp _add_text(line, ast)
  defp _add_text(line, []), do: [Ast.make_quad("p", line)]
  defp _add_text(line, [:next|rest]), do: [Ast.make_quad("p", line)|rest]
  defp _add_text(line, [parent|rest]), do: [Ast.add_text_to_content(parent, line)|rest]

end

#  SPDX-License-Identifier: Apache-2.0
