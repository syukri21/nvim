local user = vim.env.USER or "User"
user = user:sub(1, 1):upper() .. user:sub(2)
return {
  auto_insert_mode = true,
  question_header = "  " .. user .. " ",
  answer_header = "  Copilot ",
  window = {
    width = 0.4,
  },
  model = "gpt-4o-2024-11-20",
}
