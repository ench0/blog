defmodule Blog.Repo.Migrations.CreatePostTags do
  use Ecto.Migration

  def change do
    create table(:post_tags, primary_key: false) do
      add :post_id, references(:base_posts, on_replace: :update)#, on_delete: :delete_all)#, on_replace: :update)
      add :tag_id, references(:org_tags, on_replace: :update)#, on_delete: :delete_all)#, on_replace: :update)
    end
  end
end
