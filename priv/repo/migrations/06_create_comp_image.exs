defmodule Blog.Repo.Migrations.CreateBlog.Comp.Image do
  use Ecto.Migration

  def change do
    create table(:comp_images) do
      add :image, :string
      add :name, :string
      add :post_id, references(:base_posts, on_delete: :delete_all)
      add :page_id, references(:base_pages, on_delete: :delete_all)
      add :order, :integer, default: 0, null: false

      timestamps()
    end

    create index(:comp_images, [:post_id])
    create index(:comp_images, [:page_id])
    create unique_index(:comp_images, [:image, :post_id, :page_id])

  end
end
