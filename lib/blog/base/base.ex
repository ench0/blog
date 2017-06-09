defmodule Blog.Base do
  @moduledoc """
  The boundary for the Base system.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo

  alias Blog.Base.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts_full do
    Repo.all(Post)
  end

  def list_posts do
    # Repo.all(Post) |> Repo.preload [:tags, :images]
    # |> Enum.map (fn(x) -> 
    #   IO.inspect x
    #   if x == "image" do
    #     x
    #   else
    #     x
    #   end
    # end)

    query = from p in Post, where: [active: true], order_by: [desc: :inserted_at]
    posts = Repo.all(query) |> Repo.preload [:images, :tags]
    posts = Enum.map posts, fn(x) ->
      if x.active do
        [x.title,
        #  Blog.ParsingHelper.truncate(x.body, max_length: 300, omission: "..."),
         Enum.at(Blog.ParsingHelper.split_text(false, x.body), 0),
         x.slug,
         Enum.at(x.images, 0),
         Enum.join(Enum.map(x.tags, fn(x) -> x.name end), ", ")
        ]
      end
    end
    posts = Enum.reject(posts, fn(x) -> x == nil end)
    # IO.puts "===posts==="
    # IO.inspect posts
    # |> Enum.reduce(fn(x) -> x.name end)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id) |> Repo.preload [:tags, :images]
  def get_post(id) do
    if Blog.ParsingHelper.is_numeric(id), do: Repo.get(Post, id) |> Repo.preload([tags: (from t in Blog.Org.Tag, order_by: t.name), images: (from i in Blog.Comp.Image, order_by: i.order)])#Repo.preload [:tags, :images]
  end
  def get_post_by(slug), do: Repo.get_by(Post, slug: slug) |> Repo.preload([tags: (from t in Blog.Org.Tag, order_by: t.name), images: (from i in Blog.Comp.Image, order_by: i.order)])

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end








  alias Blog.Base.Page

  @doc """
  Returns the list of pages.

  ## Examples

      iex> list_pages()
      [%Page{}, ...]

  """
  def list_pages do
    Repo.all(Page)
  end

  @doc """
  Gets a single page.

  Raises `Ecto.NoResultsError` if the Page does not exist.

  ## Examples

      iex> get_page!(123)
      %Page{}

      iex> get_page!(456)
      ** (Ecto.NoResultsError)

  """
  def get_page!(id), do: Repo.get!(Page, id) |> Repo.preload :images
  def get_page(id) do
    if Blog.ParsingHelper.is_numeric(id), do: Repo.get(Page, id) |> Repo.preload :images
  end
  def get_page_by(slug), do: Repo.get_by(Page, slug: slug) |> Repo.preload :images

  @doc """
  Creates a page.

  ## Examples

      iex> create_page(%{field: value})
      {:ok, %Page{}}

      iex> create_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_page(attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a page.

  ## Examples

      iex> update_page(page, %{field: new_value})
      {:ok, %Page{}}

      iex> update_page(page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_page(%Page{} = page, attrs) do
    page
    |> Page.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Page.

  ## Examples

      iex> delete_page(page)
      {:ok, %Page{}}

      iex> delete_page(page)
      {:error, %Ecto.Changeset{}}

  """
  def delete_page(%Page{} = page) do
    Repo.delete(page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking page changes.

  ## Examples

      iex> change_page(page)
      %Ecto.Changeset{source: %Page{}}

  """
  def change_page(%Page{} = page) do
    Page.changeset(page, %{})
  end




  def about do
    about = Repo.get!(Page, 1)
    about = Enum.at(Blog.ParsingHelper.split_text(false, about.body), 0)
  end
end
