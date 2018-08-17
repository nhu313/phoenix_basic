defmodule Fawkes.Profile do
  @moduledoc """
  Context responsible for managing profile information
  """

  import Ecto.Query
  alias Fawkes.Profile.User
  alias Fawkes.Repo
  alias Fawkes.Profile.Info
  @spec get_user(pos_integer) :: User.t | nil
  @spec fetch_or_create_for_user(User.t) :: Info.t
  @spec fetch_info(User.t) :: Info.t
  @spec info_changeset(Info.t | nil) :: Ecto.Changeset.t | nil
  @spec update_info(User.t, map) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @doc """
  Gets a single user. Returns a tuple with the status of the result.
  """
  def get_user(id) do
    User
    |> preload([:profile])
    |> where([user], user.id == ^id)
    |> Repo.one
  end

  @doc """
  Given a string or atom used as an user profile slug - returns a user profile
  """
  def fetch_user_profile(slug) do
    Info
    |> where([info], info.slug == ^slug)
    |> Repo.one
  end

  @doc """
  Given a User - finds or created a new user profile for that user.
  """
  def fetch_or_create_for_user(%User{} = user) do
    with %Info{} = profile <- fetch_info(user) do
      profile
    else
      nil -> %Info{} |> Info.init_changeset(%{user_id: user.id, slug: "user_#{user.id}"}) |> Repo.insert!
    end
  end
  def fetch_or_create_for_user(_), do: nil

  @doc """
  Given a user - returns the profile information for that user
  """
  def fetch_info(profile_user) do
    Info
    |> where([info], info.user_id == ^profile_user.id)
    |> Repo.one
  end

  @doc """
  Given profile information - returns a changeset for that information
  """
  def info_changeset(nil), do: nil
  def info_changeset(info) do
    Info.changeset(info, %{})
  end

  @doc """
  Given a user with preloaded profile information and a params map -
  attempts to updates the profile info with the given params
  """
  def update_info(%User{profile: profile}, params) when not is_nil profile do
    profile
    |> Info.changeset(params)
    |> Repo.update
  end
end
