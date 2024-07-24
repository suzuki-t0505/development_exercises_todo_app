alias TestTodoApp.Repo
alias TestTodoApp.Accounts.User
alias TestTodoApp.Tasks.Task

Enum.each(~w(user00 user01 user02 user03), fn name ->
  user =
    Repo.insert!(
      %User{
        email: name <> "@example.com",
        hashed_password: Bcrypt.hash_pwd_salt(name <> "999"),
        confirmed_at: DateTime.truncate(DateTime.utc_now(), :second)
      }
    )

  Enum.each(1..3, fn i ->
    Repo.insert!(
      %Task{
        title: "タスク#{i}",
        date: ~D[2024-07-26],
        user_id: user.id
      }
    )
  end)
end)
