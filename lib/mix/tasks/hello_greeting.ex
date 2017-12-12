defmodule Mix.Tasks.HelloGreeting do
  use Mix.Task

  @shortdoc "Sends a greeting Hello Phoenix"

  @moduledoc """
    This is where we would put any long form documentation or doctests.
  """

  def run(_args) do
    Mix.Task.run "app.start"
    Mix.shell.info "This custom mix task has access to Repo and other infrastructure but doesn't do anything yet!"
  end

  # We can define other functions as needed here.
end
