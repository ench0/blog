defmodule Blog.Org.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Org.Tag


  schema "org_tags" do
    field :name, :string
    field :slug, :string
    field :active, :boolean, default: true

    many_to_many :posts, Blog.Base.Post, join_through: Blog.Org.PostTag
    # has_many :taggings, Readdit.Tagging
    # has_many :posts, through: [:taggings, :post]

  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name, :slug, :active])
    |> validate_required([:name, :slug, :active])
    |> validate_length(:name, max: 250, message: "It has to be less than 250 characters")
    |> unique_constraint(:name, message: "There is a post with the same title")
    |> unique_constraint(:slug, message: "There is a post with the same url")
  end
end
