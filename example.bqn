
⟨_Repl⟩←•Import "readline.bqn"

r←•ReBQN {repl⇐"loose"}

Repl {
  prompt⇐"    " 
  Cmd⇐{ 
    •Out prompt∾𝕩
    •Show R⎊•CurrentError 𝕩 
  }
}
