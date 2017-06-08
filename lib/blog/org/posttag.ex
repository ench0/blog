defmodule Blog.Org.PostTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Org.Posttag

  schema "post_tags" do
    belongs_to :post, Blog.Base.Post
    belongs_to :tag, Blog.Org.Tag
  end

end