defmodule Blog.Repo.Migrations.CreateBlog.Org.Tag do
  use Ecto.Migration

  def change do
    create table(:org_tags) do
      add :name, :string
      add :slug, :string
      add :active, :boolean, default: true, null: false

    end

    create unique_index(:org_tags, [:name])
    create unique_index(:org_tags, [:slug])

  end
end
