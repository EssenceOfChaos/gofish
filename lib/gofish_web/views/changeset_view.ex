defmodule GofishWeb.ChangesetView do
  use GofishWeb, :view

  @doc """
  Traverses and translates changeset errors.
  """
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end
end
