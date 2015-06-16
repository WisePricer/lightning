defmodule Lightning.PageController do
  use Lightning.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
