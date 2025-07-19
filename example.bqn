
⟨_Repl⟩←•Import "readline.bqn"

r←•ReBQN {repl⇐"loose"}

{ •Out 𝕩
  •Out ("  "⊸∾∘•Fmt∘R)⎊•CurrentError 𝕩 
} _Repl @
