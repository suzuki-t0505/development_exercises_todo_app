defmodule TestTodoAppWeb.TaskController do
  use TestTodoAppWeb, :controller

  alias TestTodoApp.Tasks
  alias TestTodoApp.Tasks.Task

  def index(conn, %{"search" => search}) do
    tasks = Tasks.search_task(conn.assigns.current_user.id, search)
    render(conn, :index, tasks: tasks, search_text: search)
  end

  def index(conn, _params) do
    tasks = Tasks.list_tasks(conn.assigns.current_user.id)
    render(conn, :index, tasks: tasks, search_text: "")
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    task_params = Map.merge(task_params, %{"user_id" => conn.assigns.current_user.id})
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: ~p"/tasks/#{task}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, :show, task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, :edit, task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: ~p"/tasks/#{task}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: ~p"/tasks")
  end
end
