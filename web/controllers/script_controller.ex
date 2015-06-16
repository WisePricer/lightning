defmodule Lightning.ScriptController do
  use Lightning.Web, :controller
  use Hound.Helpers

  plug :action

  def run(conn, _params) do
    script = _params["script"]

    hound_session
    script
      |> Enum.map(&parse/1)
      |> Enum.map(&execute_command/1)
      |> Enum.each &IO.inspect/1

    conn |>
      json %{status: "success"}
  end

  def on_exit _ do
  end
  def setup _ do
  end

  def parse cmd do
    String.split(cmd)
  end

  def execute_command cmd do
    step_id = SecureRandom.urlsafe_base64(8)
    execute cmd

    filename = "screenshots/#{step_id}.png"
    screenshot_path = "priv/static/#{filename}"
    screenshot_url = "/#{filename}"
    take_screenshot(screenshot_path)
    %{
      step_id: step_id,
      title: page_title(),
      screenshot_url: screenshot_url
    }
  end

  def execute ["goto", url] do
    navigate_to(url)
  end

  def execute ["click", selector] do
    find_element(:css, selector)
      |> click()
  end

  def execute ["enter", text, "in", selector] do
    find_element(:css, selector)
      |> fill_field(text)
  end
end
