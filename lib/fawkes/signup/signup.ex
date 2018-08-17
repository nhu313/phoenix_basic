defmodule Fawkes.Signup do
  @moduledoc """
  Context responsible for adding new users to the system
  """

  alias Fawkes.Repo
  alias Fawkes.Signup.User

  @spec change_user(User.t) :: Ecto.Changeset.t
  @spec create_user(map) :: {:ok, User.t} | {:error, Ecto.Changeset.t}

  @doc """
  Provides an empty changeset for use in new user forms
  """
  def change_user(%User{} = user) do
    user
    |> User.changeset(%{})
  end

  @doc """
  Given a valid set of attributes creates a new user
  """
  def create_user(attrs \\ %{}) do
    with {:ok, user} <- %User{}
                        |> User.registration_changeset(attrs)
                        |> Repo.insert() do
      {:ok, user}
    else
      {:error, user_changeset} -> {:error, user_changeset}
    end
  end
end
