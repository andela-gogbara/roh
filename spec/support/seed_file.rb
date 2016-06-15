module TodoSeed
  def create_todo
    todo = Todo.new(
      title: "Defence",
      body: "4",
      status: "Pending",
      created_at: Time.now
    )

    todo.save
    todo
  end

  def seed(n = 1)
  (1..n).each  do |i|
    todo = Todo.new
    todo.title = "task#{i}"
    todo.body =  "body#{i}"
    todo.status = "pending"
    todo.created_at = Time.now.to_s
    todo.save
  end
end
end
