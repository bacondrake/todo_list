json.array!(@todos) do |todo|
  json.extract! todo, :id, :content, :section, :date_created, :date_completed
  json.url todo_url(todo, format: :json)
end
