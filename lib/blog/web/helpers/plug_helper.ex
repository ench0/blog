defmodule Blog.PlugHelper do
  import Plug.Conn

  def init(options), do: options

  # def call(conn, _opts) do
  #   conn
  #   |> put_resp_content_type("text/plain")
  #   |> send_resp(200, "Hello World!")
  # end

  def timer_start(conn, _opts) do
    start = Timex.now
    # conn["params"] = %{koko: "koko"}
    # IO.puts "started"
    # IO.inspect conn.params
    conn |> assign(:start, start)

  end

  def timer_end(conn, _opts) do
    start = conn.assigns.start
    finish = Timex.now
    # dur = Timex.diff(finish, start, :milliseconds)
    dur = Timex.diff(finish, start, :microseconds)
    # IO.puts "ended"
    # IO.inspect start
    # IO.inspect finish
    # IO.inspect dur
    conn |> assign(:dur, dur)
  end
    # # start stopwatch
    # start = Timex.now

    # # stop stopwatch
    # finish = Timex.now
    # dur = Timex.diff(finish, start, :milliseconds)

end