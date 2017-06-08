defmodule Blog.Repo.Migrations.CreateBlog.Base.Page do
  use Ecto.Migration

  def change do
    create table(:base_pages) do
      add :title, :string
      add :slug, :string
      add :body, :string, size: 131072
      add :active, :boolean, default: false, null: false
      add :menu, :integer, default: 0, null: false

      timestamps()
    end

  end
end
