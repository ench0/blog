defmodule Blog.Base.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Base.Post

  import Ecto.Query
  alias Blog.Repo

  schema "base_posts" do
    field :title, :string
    field :slug, :string
    field :body, :string
    field :active, :boolean, default: false

    many_to_many :tags, Blog.Org.Tag, join_through: "post_tags", on_replace: :delete
    has_many :images, Blog.Comp.Image, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs \\ %{}) do 
  # image = Ecto.Changeset.change(%Blog.Comp.Image{}, name: "Excellent!")
    post
    |> cast(attrs, [:title, :slug, :body, :active])
    |> put_assoc(:tags, parse_tags(attrs))#posttag
    |> cast_assoc(:images)
    # |> cast_assoc(:tags)
    |> validate_required([:title, :slug, :active])
    |> validate_length(:title, max: 250, message: "It has to be less than 250 characters")
    |> validate_length(:body, max: 130000, message: "It has to be less than 130000 characters")
    |> unique_constraint(:title, message: "There is a post with the same title")
    |> unique_constraint(:slug, message: "There is a post with the same url")
  end



  # posttag
  defp parse_tags(params)  do
    (params["tags"] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(& &1 == "")
    |> insert_and_get_all()
  end

  defp insert_and_get_all([]) do
    []
  end
  defp insert_and_get_all(names) do
    maps = Enum.map(names, &%{name: &1, slug: Slugger.slugify(&1)})
    Repo.insert_all Blog.Org.Tag, maps, on_conflict: :nothing
    Repo.all(from t in Blog.Org.Tag, where: t.name in ^names)
  end



end
