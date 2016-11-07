defmodule Nopare.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/:id" do
    # TODO: dispatch request for package metadata to registry
    conn |> redirect("https://registry.npmjs.org/#{id}")
  end

  get "/:id/-/:tgz" do
    # TODO: dispatch request for tarball to
    conn |> redirect("https://registry.npmjs.org/#{id}/-/#{tgz}")
  end

  def redirect(conn, url) do
    conn
      |> put_resp_header("location", url)
      |> send_resp(302, url)
  end
end
