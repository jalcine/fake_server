defmodule Fakex.BehaviorTest do
  use ExUnit.Case
  doctest Fakex

  @valid_behavior %{response_body: "\"user\": \"test\"", response_code: 200}

  test "#begin start a new agent with module name and empty Keyword list" do
    Fakex.Behavior.begin
    assert Agent.get(Fakex.Behavior, fn(list) -> list end) == []
    Agent.stop(Fakex.Behavior)
  end

  test "#add return error if name is not atom" do
    assert Fakex.Behavior.add("some_invalid_name", @valid_behavior) == {:error, :invalid_name}
  end

  test "#add returns error if name not provided" do
    assert Fakex.Behavior.add(@valid_behavior) == {:error, :name_not_provided}
  end

  test "#add returns error if response_body not provided" do
    assert Fakex.Behavior.add(:test, %{response_code: 200}) == {:error, :response_body_not_provided}
  end

  test "#add returns error if response_code not provided" do
    assert Fakex.Behavior.add(:test, %{response_body: ~s<"user": "test">}) == {:error, :response_code_not_provided}
  end

  test "#add put a new behavior on the list" do
    Fakex.Behavior.begin
    assert Agent.get(Fakex.Behavior, fn(list) -> list end) == []
    Fakex.Behavior.add(:test, @valid_behavior) == {:error, :response_code_not_provided}
    assert Agent.get(Fakex.Behavior, fn(list) -> list end) == [test: @valid_behavior]
  end
end