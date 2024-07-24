defmodule TestTodoApp.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TestTodoApp.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        date: ~D[2024-07-23],
        title: "some title"
      })
      |> TestTodoApp.Tasks.create_task()

    task
  end
end
