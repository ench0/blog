defmodule Blog.OrgTest do
  use Blog.DataCase

  alias Blog.Org

  describe "tags" do
    alias Blog.Org.Tag

    @valid_attrs %{active: true, list: [], slug: "some slug"}
    @update_attrs %{active: false, list: [], slug: "some updated slug"}
    @invalid_attrs %{active: nil, list: nil, slug: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Org.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Org.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Org.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Org.create_tag(@valid_attrs)
      assert tag.active == true
      assert tag.list == []
      assert tag.slug == "some slug"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Org.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, tag} = Org.update_tag(tag, @update_attrs)
      assert %Tag{} = tag
      assert tag.active == false
      assert tag.list == []
      assert tag.slug == "some updated slug"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Org.update_tag(tag, @invalid_attrs)
      assert tag == Org.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Org.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Org.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Org.change_tag(tag)
    end
  end
end
