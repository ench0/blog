defmodule Blog.Base.Page do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Base.Page

  import Ecto.Query
  alias Blog.Repo

  schema "base_pages" do
    field :title, :string
    field :slug, :string
    field :body, :string
    field :active, :boolean, default: false
    field :menu, :integer, default: 0, null: false

    has_many :images, Blog.Comp.Image, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Page{} = page, attrs) do
    page
    |> cast(attrs, [:title, :slug, :body, :active, :menu])
    |> cast_assoc(:images)
    |> validate_required([:title, :slug, :body, :active, :menu])
  end
end
