; Inject rstml language inside Leptos-like view! macro bodies
((macro_invocation
   macro: (identifier) @macro_name
   (#match? @macro_name "view"))
  (token_tree) @rstml
  (#set! injection.language "rstml"))
