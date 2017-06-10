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

  describe "files" do
    alias Blog.Comp.File

    @valid_attrs %{file: "some file", name: "some name"}
    @update_attrs %{file: "some updated file", name: "some updated name"}
    @invalid_attrs %{file: nil, name: nil}

    def file_fixture(attrs \\ %{}) do
      {:ok, file} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Comp.create_file()

      file
    end

    test "list_files/0 returns all files" do
      file = file_fixture()
      assert Comp.list_files() == [file]
    end

    test "get_file!/1 returns the file with given id" do
      file = file_fixture()
      assert Comp.get_file!(file.id) == file
    end

    test "create_file/1 with valid data creates a file" do
      assert {:ok, %File{} = file} = Comp.create_file(@valid_attrs)
      assert file.file == "some file"
      assert file.name == "some name"
    end

    test "create_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comp.create_file(@invalid_attrs)
    end

    test "update_file/2 with valid data updates the file" do
      file = file_fixture()
      assert {:ok, file} = Comp.update_file(file, @update_attrs)
      assert %File{} = file
      assert file.file == "some updated file"
      assert file.name == "some updated name"
    end

    test "update_file/2 with invalid data returns error changeset" do
      file = file_fixture()
      assert {:error, %Ecto.Changeset{}} = Comp.update_file(file, @invalid_attrs)
      assert file == Comp.get_file!(file.id)
    end

    test "delete_file/1 deletes the file" do
      file = file_fixture()
      assert {:ok, %File{}} = Comp.delete_file(file)
      assert_raise Ecto.NoResultsError, fn -> Comp.get_file!(file.id) end
    end

    test "change_file/1 returns a file changeset" do
      file = file_fixture()
      assert %Ecto.Changeset{} = Comp.change_file(file)
    end
  end
end
