defmodule LoosenessTest do
  use ExUnit.Case, async: true

  test "bad structured header 1" do
    message = File.read!("test/fixtures/bad_structured_header1.eml")
    |> Mail.Parsers.RFC2822.parse
    assert message.headers["content-type"] == "application/pdf"
  end

  test "bad structured header 2" do
    message = File.read!("test/fixtures/bad_structured_header2.eml")
    |> Mail.Parsers.RFC2822.parse

    assert message.headers["content-type"] == [
      "application/octet-stream",
      {"name", ~s("FantasticMachine21.wmv")}
    ]
  end

  test "bad header body separation" do
    message = File.read!("test/fixtures/bad_header_body_separation.eml")
    |> Mail.Parsers.RFC2822.parse
    assert message.body == "Some text"
  end

  test "bad dates" do
    assert Mail.Parsers.RFC2822.erl_from_timestamp("24 JUL 2009 15:19:16 -0500")
      == {{2009, 7, 24}, {15, 19, 16}}
  end

end
