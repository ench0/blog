defmodule Blog.BaseTest do
  use Blog.DataCase

  alias Blog.Base

  describe "posts" do
    alias Blog.Base.Post

    @valid_attrs %{active: true, slug: "some slug", title: "some title"}
    @update_attrs %{active: false, slug: "some updated slug", title: "some updated title"}
    @invalid_attrs %{active: nil, slug: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Base.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Base.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Base.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Base.create_post(@valid_attrs)
      assert post.active == true
      assert post.slug == "some slug"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Base.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Base.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.active == false
      assert post.slug == "some updated slug"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Base.update_post(post, @invalid_attrs)
      assert post == Base.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Base.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Base.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Base.change_post(post)
    end
  end

  describe "pages" do
    alias Blog.Base.Page

    @valid_attrs %{active: true, body: "some body", menu: true, slug: "some slug", title: "some title"}
    @update_attrs %{active: false, body: "some updated body", menu: false, slug: "some updated slug", title: "some updated title"}
    @invalid_attrs %{active: nil, body: nil, menu: nil, slug: nil, title: nil}

    def page_fixture(attrs \\ %{}) do
      {:ok, page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Base.create_page()

      page
    end

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Base.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Base.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = Base.create_page(@valid_attrs)
      assert page.active == true
      assert page.body == "some body"
      assert page.menu == true
      assert page.slug == "some slug"
      assert page.title == "some title"
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Base.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      assert {:ok, page} = Base.update_page(page, @update_attrs)
      assert %Page{} = page
      assert page.active == false
      assert page.body == "some updated body"
      assert page.menu == false
      assert page.slug == "some updated slug"
      assert page.title == "some updated title"
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Base.update_page(page, @invalid_attrs)
      assert page == Base.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Base.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Base.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Base.change_page(page)
    end
  end
end
