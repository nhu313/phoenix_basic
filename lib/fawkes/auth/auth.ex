defmodule Fawkes.Auth do
  @moduledoc """
  Context responsible for authenticating users
  """

  import Ecto.Query, warn: false
  alias Comeonin.Bcrypt
  alias Fawkes.Auth.User
  alias Fawkes.Repo

  @type password_check_func :: (String.t, String.t -> boolean)
  @type rtrn :: {:ok, User.t} | {:error, :incorrect}

  @spec authenticate_user(String.t, String.t, password_check_func) :: rtrn
  @spec change_user(User.t) :: Ecto.Changeset.t

  @doc """
  Given a username and password attempts to authenticate the user.

  Returns a sucess tuple with the user or :incorrect
  """
  def authenticate_user(username, password, checkpw \\ &Bcrypt.checkpw/2)
  def authenticate_user(username, plain_text_password, checkpw) do
    username
    |> user_by_username_query()
    |> Repo.one()
    |> check_password(plain_text_password, checkpw)
  end

  @doc """
  Given a user, returns a user changeset for that user.

  In practice this just expects an empty Auth.User struct to create an
  empty changeset for use in a login form.
  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @spec check_password(User.t, String.t, password_check_func) :: rtrn
  defp check_password(%User{} = user, plain_text_password, checkpw) do
    plain_text_password
    |> checkpw.(user.password)
    |> case do
         true -> {:ok, user}
         false -> {:error, :incorrect}
       end
  end
  defp check_password(_, _, _), do: {:error, :incorrect}

  @spec user_by_username_query(String.t) :: Ecto.Query.t
  defp user_by_username_query(username) do
    from u in User, where: u.username == ^username
  end
end
