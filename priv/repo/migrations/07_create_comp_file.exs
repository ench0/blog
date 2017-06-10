defmodule Blog.Repo.Migrations.CreateBlog.Comp.File do
  use Ecto.Migration

  def change do
    create table(:comp_files) do
      add :file, :string
      add :name, :string
      add :post_id, references(:base_posts, on_delete: :delete_all)
      add :page_id, references(:base_pages, on_delete: :delete_all)
      add :order, :integer, default: 0, null: false

      timestamps()
    end

    create index(:comp_files, [:post_id])
    create index(:comp_files, [:page_id])
    create unique_index(:comp_files, [:file, :post_id, :page_id])

  end
end
