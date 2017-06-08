defmodule Blog.Mailer do
  @moduledoc """
  Swoosh mailer for Blog.
  """

  use Swoosh.Mailer, otp_app: :blog
end
