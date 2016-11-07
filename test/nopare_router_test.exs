defmodule NopareRouterTest do
  use ExUnit.Case, async: true
  use Plug.Test
  doctest Nopare.Router

  @opts Nopare.Router.init([])

  test "a package metadata request" do
    # Create a test connection
    conn = conn(:get, "/npm")

    # Invoke the plug
    conn = Nopare.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 302
    assert get_resp_header(conn, "location") == ["https://registry.npmjs.org/npm"]
    assert conn.resp_body == "https://registry.npmjs.org/npm"
  end

  test "a package tarball request" do
    # Create a test connection
    conn = conn(:get, "/npm/-/npm-4.0.1.tgz")

    # Invoke the plug
    conn = Nopare.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 302
    assert conn.resp_body == "https://registry.npmjs.org/npm/-/npm-4.0.1.tgz"
  end
end
