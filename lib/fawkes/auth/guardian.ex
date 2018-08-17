defmodule Fawkes.Auth.Guardian do
  @moduledoc """
  Provides callbacks for Guardian to use when authenticating users
  """

  use Guardian, otp_app: :fawkes
  alias Fawkes.Profile
  alias Fawkes.Profile.User, as: ProfileUser
  alias Fawkes.Auth.User, as: AuthUser
  alias Fawkes.Signup.User, as: SignupUser

  @type get_user_func :: (String.t -> boolean)

  @spec subject_for_token(AuthUser.t | SignupUser.t, any) :: {:ok, String.t}
  @spec resource_from_claims(%{String.t => String.t}, get_user_func) ::
        {:ok, ProfileUser.t} | {:error, :not_found}

  @doc """
  Given a user struct returns the id for use as a token

  This is used with resource_from_claims by Guardian to find the user associated
  with a JWT
  """
  def subject_for_token(%AuthUser{} = user, _), do: {:ok, to_string(user.id)}
  def subject_for_token(%SignupUser{} = user, _), do: {:ok, to_string(user.id)}

  @doc """
  Given a Guardian claim map returns a User Profile.
  """
  def resource_from_claims(claims, get_user \\ &Profile.get_user/1) do
    case get_user.(claims["sub"]) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end
