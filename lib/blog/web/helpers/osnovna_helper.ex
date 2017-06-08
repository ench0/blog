defmodule ElAsr.OsnovnaHelper do
      alias ElAsr.Repo
      alias ElAsr.Baza.Osnovna
      import Ecto.Query

  def osnovne_menu do
    query = from(s in Osnovna, order_by: s.order)
    osnovne = Repo.all(query)

    osnovne = Enum.filter_map(osnovne, fn(x) -> 
            if x.active && x.menu do
              x
            end
          end, &([&1.naslov, &1.slug]))
          # IO.inspect osnovne
  end


  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if path == current_path do
      "pure-menu-selected"
    else
      nil
    end
  end

  def edit_link(conn) do
    edit_path = Path.join(["/", conn.path_info, "edit"])
  end





  def active_link(conn, path, opts) do
    class = [opts[:class], active_class(conn, path)]
            |> Enum.filter(& &1) 
            |> Enum.join(" ")
    opts = opts
          |> Keyword.put(:class, class)
          |> Keyword.put(:to, path)
    # link text, opts
  end


end