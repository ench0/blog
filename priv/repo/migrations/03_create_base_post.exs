defmodule Blog.Repo.Migrations.CreateBlog.Base.Post do
  use Ecto.Migration

  def change do
    create table(:base_posts) do
      add :title, :string
      add :slug, :string
      add :body, :string, size: 131072
      add :active, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:base_posts, [:title])
    create unique_index(:base_posts, [:slug])

  end
end
