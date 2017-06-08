defmodule Blog.Comp.Image do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Comp.Image

  use Arc.Ecto.Schema
  import Blog.ParsingHelper

  schema "comp_images" do
    field :image, Blog.ImageUploader.Type
    # field :image, :string
    field :name, :string
    field :post_id, :id
    field :page_id, :id
    field :order, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(%Image{} = image, attrs) do
    image
    |> cast(attrs, [:name, :post_id, :page_id, :order])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:image, :name])
  end
end
