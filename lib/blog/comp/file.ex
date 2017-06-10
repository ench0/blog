defmodule Blog.Comp.File do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Comp.File

  use Arc.Ecto.Schema
  import Blog.ParsingHelper

  schema "comp_files" do
    field :file, Blog.FileUploader.Type
    # field :file, :string
    field :name, :string
    field :post_id, :id
    field :page_id, :id
    field :order, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(%File{} = file, attrs) do
    file
    |> cast(attrs, [:name, :post_id, :page_id, :order])
    |> cast_attachments(attrs, [:file])
    |> validate_required([:file, :name])
  end
end
