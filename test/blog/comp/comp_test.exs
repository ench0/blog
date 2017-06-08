defmodule Blog.CompTest do
  use Blog.DataCase

  alias Blog.Comp

  describe "forms" do
    alias Blog.Comp.Form

    @valid_attrs %{active: true, info: "some info", title: "some title"}
    @update_attrs %{active: false, info: "some updated info", title: "some updated title"}
    @invalid_attrs %{active: nil, info: nil, title: nil}

    def form_fixture(attrs \\ %{}) do
      {:ok, form} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Comp.create_form()

      form
    end

    test "list_forms/0 returns all forms" do
      form = form_fixture()
      assert Comp.list_forms() == [form]
    end

    test "get_form!/1 returns the form with given id" do
      form = form_fixture()
      assert Comp.get_form!(form.id) == form
    end

    test "create_form/1 with valid data creates a form" do
      assert {:ok, %Form{} = form} = Comp.create_form(@valid_attrs)
      assert form.active == true
      assert form.info == "some info"
      assert form.title == "some title"
    end

    test "create_form/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comp.create_form(@invalid_attrs)
    end

    test "update_form/2 with valid data updates the form" do
      form = form_fixture()
      assert {:ok, form} = Comp.update_form(form, @update_attrs)
      assert %Form{} = form
      assert form.active == false
      assert form.info == "some updated info"
      assert form.title == "some updated title"
    end

    test "update_form/2 with invalid data returns error changeset" do
      form = form_fixture()
      assert {:error, %Ecto.Changeset{}} = Comp.update_form(form, @invalid_attrs)
      assert form == Comp.get_form!(form.id)
    end

    test "delete_form/1 deletes the form" do
      form = form_fixture()
      assert {:ok, %Form{}} = Comp.delete_form(form)
      assert_raise Ecto.NoResultsError, fn -> Comp.get_form!(form.id) end
    end

    test "change_form/1 returns a form changeset" do
      form = form_fixture()
      assert %Ecto.Changeset{} = Comp.change_form(form)
    end
  end

  describe "images" do
    alias Blog.Comp.Image

    @valid_attrs %{image: "some image", name: "some name"}
    @update_attrs %{image: "some updated image", name: "some updated name"}
    @invalid_attrs %{image: nil, name: nil}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Comp.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Comp.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Comp.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Comp.create_image(@valid_attrs)
      assert image.image == "some image"
      assert image.name == "some name"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comp.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, image} = Comp.update_image(image, @update_attrs)
      assert %Image{} = image
      assert image.image == "some updated image"
      assert image.name == "some updated name"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Comp.update_image(image, @invalid_attrs)
      assert image == Comp.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Comp.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Comp.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Comp.change_image(image)
    end
  end
end
