defmodule Lightning.ScriptController do
  use Lightning.Web, :controller

  plug :action

  def run(conn, _params) do
    IO.inspect _params
    conn |>
      json %{status: "success"}
  end
end
