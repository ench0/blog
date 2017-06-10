defmodule Blog.FileUploader do
  use Arc.Definition

  # Include ecto support (requires package arc_ecto installed):
  use Arc.Ecto.Definition

  @versions [:original]

  # To add a thumbnail version:
  # @versions [:original, :thumb]

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.txt .pdf .zip .doc .docx) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  # def transform(:thumb, _) do
  #   {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  # end

  # Override the persisted filenames:
  # def filename(version, _) do
  #   version
  # end

  # Override the storage directory:
  # def storage_dir(version, {file, scope}) do
  #   "files/docs/#{scope.id}"
  # end
  def storage_dir(version, {file, scope}) do
    # IO.puts "!!!!!file!!!!!"
    # IO.inspect file
    # IO.puts "!!!!!scope!!!!!"
    # IO.inspect scope
    cond do
      is_integer scope ->
        "files/docs/misc/#{scope}"
      scope.post_id ->
        "files/docs/posts/#{scope.post_id}"
      scope.page_id ->
        "files/docs/pages/#{scope.page_id}"
      true ->
        "files/docs/misc/#{scope}"
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
