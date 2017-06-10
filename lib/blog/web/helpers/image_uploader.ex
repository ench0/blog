defmodule Blog.ImageUploader do
  use Arc.Definition

  # Include ecto support (requires package arc_ecto installed):
  use Arc.Ecto.Definition

  # To add a thumbnail version:
  @versions [:original, :normal, :thumb]

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png .JPG .JPEG .GIF .PNG) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  # def transform(:thumb, _) do
  #   {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  # end
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity North -extent 250x250 -format png", :png}
  end

  def transform(:normal, _) do
    # {:convert, "-strip -filter spline -resize 1200^ -unsharp 0x1 -quality 85 -format jpg", :jpg}
    {:convert, "-strip -filter spline -resize 1200> -unsharp 0x1 -quality 85 -format jpg", :jpg}
  end

  # Override the persisted filenames:
  # def filename(version, _) do
  #   version
  # end

  def filename(version, {file, scope}) do
    filename = String.replace(file.file_name, ".jpg", "") |> String.replace(".jpeg", "") |> String.replace(".gif", "") |> String.replace(".png", "") |> String.replace(".JPG", "") |> String.replace(".JPEG", "") |> String.replace(".GIF", "") |> String.replace(".PNG", "")
    String.replace(Slugger.slugify_downcase("#{version}_#{filename}"), "allah", "Allah")
  end


  # Override the storage directory:
  def storage_dir(version, {file, scope}) do
    # IO.puts "!!!!!file!!!!!"
    # IO.inspect file
    # IO.puts "!!!!!scope!!!!!"
    # IO.inspect scope
    cond do
      is_integer scope ->
        "files/images/misc/#{scope}"
      scope.post_id ->
        "files/images/posts/#{scope.post_id}"
      scope.page_id ->
        "files/images/pages/#{scope.page_id}"
      true ->
        "files/images/misc/#{scope}"
    end
    # "uploads/user/avatars/#{scope.id}"
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: Plug.MIME.path(file.file_name)]
  # end
end
