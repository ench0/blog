defmodule Blog.ParsingHelper do

  def sort_string(string) do
    string
    |> String.downcase
    |> String.normalize(:nfd)
    |> String.graphemes

    # |> Enum.sort
  end

  def split_text(intro, body) do

    # sanitize text field
    body = HtmlSanitizeEx.basic_html(body)

    cond do
      intro ->
        IO.puts "!contains intro"
        intro = "<p>"<>intro<>"</p>"
        body = body
      true ->
        IO.puts "!does not contain intro"
        cond do
          String.contains? body, ["<hr />", "<hr>"] ->
            IO.puts "!contains hr"
            body = String.replace(body, "<p><hr /></p>", "<hr />")



            split = String.split(body, ["<hr />", "<hr>"], trim: true) 
            # IO.puts "---split---"
            # IO.inspect split

            [intro | [body]] = split
            body = String.split(body, ["<p>", "</p>"], trim: true) |> Enum.map(fn(x) -> "<p>"<>x<>"</p>" end)
            # IO.puts "---body---"
            # IO.inspect body

            intro = String.trim(intro, "<p>") |> String.trim("</p>")
            intro = "<p>"<>intro<>"</p>"

            # body = String.trim(body, "<p>") |> String.trim("</p>")
            # body = "<p>"<>body<>"</p>"

            # body = Enum.map(body, )
            body = List.to_string(body)

          true ->
            IO.puts "!does not contain hr"
            split = String.split(body, ["<p>", "</p>"], trim: true)
            # IO.puts "---split---"
            # IO.inspect split
            [intro | body] = split
            body = Enum.map(body, fn(x) -> "<p>"<>x<>"</p>" end)
            body = List.to_string(body)
            intro = "<p>"<>intro<>"</p>"
        end
    end

    # if body == "" do
    #   IO.puts "hr at the end"
    #   # split = String.split(body, ["<p>", "</p>"], trim: true)
    #   # [intro | body] = split
    #   # body = List.to_string(Enum.map(body, fn(x) -> "<p>"<>x<>"</p>" end))
    #   intro = "<p>"<>intro<>"</p>"
    # end

    # String.contains?(body, "<p><strong>")
    body = Regex.replace(~r/<p><strong>([\s\S]*?)<\/strong>([\s\S]*?)<\/p>/, body, "<h3 class='inline'>\\g{1}<\/h3><p>\\g{2}</p>" )
    body = String.replace(body, "<p> </p>", "") |> String.replace("<p>&nbsp;</p>", "") |> String.replace("<p></p>", "")
    intro = String.replace(intro, "<p> </p>", "") |> String.replace("<p>&nbsp;</p>", "") |> String.replace("<p></p>", "")

    body = HtmlSanitizeEx.basic_html(body)

    # IO.puts "---intro---"
    # IO.inspect intro
    # IO.puts "---body---"
    # IO.inspect body


    [intro, body]
  end


  def word_count(intro, body) do
    
    wordcount = Enum.count(String.split(intro<>body))
    readtime = Integer.floor_div(wordcount, 130)#100-130-160 slow-average-fast reading
    # IO.puts "Wordcount:"
    # IO.inspect wordcount
    # IO.puts "Readtime:"
    # IO.inspect readtime
    # case Enum.fetch!(Integer.digits(readtime), -1) do
    case readtime do
        x when x in [0] -> readtime = "<1 minute"
        x when x in [2..20, 22..30, 32..40, 42..50]-> readtime = Integer.to_string(readtime) <> " minutes"
        x when x in [1, 21, 31, 41, 51] -> readtime = Integer.to_string(readtime) <> " minute"
        _ -> readtime = Integer.to_string(readtime) <> " minutes"
    end
  end



  def truncate(text, opts \\ []) do
    max_length  = opts[:max_length] || 50
    omission    = opts[:omission] || "..."

    cond do
      not String.valid?(text) -> 
        text
      String.length(text) < max_length -> 
        text
      true ->
        length_with_omission = max_length - String.length(omission)

        "#{String.slice(text, 0, length_with_omission)}#{omission}"
    end
  end

  def is_numeric(str) do
    case Float.parse(str) do
      {_num, ""} -> true
      _          -> false
    end
  end

end
