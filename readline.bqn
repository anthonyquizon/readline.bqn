
asc←"`1234567890-=~!@#$%^&*()_+qwertyuiop[]QWERTYUIOP{}asdfghjkl;'ASDFGHJKL:""|zxcvbnm,./ZXCVBNM<>?"
uni←"˜˘¨⁼⌜´˝7∞¯•÷×¬⎉⚇⍟◶⊘⎊⍎⍕⟨⟩√⋆⌽𝕨∊↑∧y⊔⊏⊐π←→↙𝕎⍷𝕣⍋YU⊑⊒⍳⊣⊢⍉𝕤↕𝕗𝕘⊸∘○⟜⋄↩↖𝕊D𝔽𝔾«J⌾»·˙|⥊𝕩↓∨⌊n≡∾≍≠⋈𝕏C⍒⌈N≢≤≥⇐"

e←@+27 ⋄ clear←e∾"[2K"∾e∾"[0G"

Repl⇐{𝕊 opt:
  •term.RawMode 1
  •term.OutRaw •ToUTF8 opt.prompt

  ch←⟨⟩ ⋄ ps←0

  Cmd←{ch 𝕊 ·: •term.OutRaw clear⋄opt.Cmd ch}

  # add 𝕩 into ch at ps position with 𝕨 deletions
  Patch←{0=≠ch?⟨⟩;∾(∾⟜𝕩(-𝕨)⊸↓)¨⌾(1⊸↑) ps(⊢⊔˜≤⟜(↕≠))ch} 

  # map of inputs to ⟨ch, ps, eff⟩ 
  # ch: new character list, ps: position, eff: side effect function⟩
  Map←{
    𝕩:𝕩≡e∾"[D"             ? ⟨ch,            0⌈ps-1,          {𝕩}   ⟩
  ; 𝕩:𝕩≡e∾"[C"             ? ⟨ch,            (≠ch)⌊ps+1,      {𝕩}   ⟩
  ; 𝕩:𝕩≡≍@+10              ? ⟨⟨⟩,            0,               ch⊸Cmd⟩ # enter
  ; 𝕩:𝕩≡≍@+127             ? ⟨1 Patch "",    0⌈ps-1,          {𝕩}   ⟩ # backspace
  ; 𝕩:𝕩≡≍@+21              ? ⟨⟨⟩,            0,               {𝕩}   ⟩ # ctrl+u
  ; 𝕩:0=≠ch                ? ⟨𝕩,             1,               {𝕩}   ⟩
  ; 𝕩:'\'=ch(⊣⊑˜0⌈≠⊸⌊)ps-1 ? z←uni/˜asc∊𝕩
                             ⟨ch0←1 Patch z, (≠z)+ps-1,       {𝕩}   ⟩
  ; 𝕩:                       ⟨ch0←0 Patch 𝕩, ps+1,            {𝕩}   ⟩ 
  }

  # if e consume chars until letter (ANSI format for keypresses)
  Input←{
     𝕊@:𝕊•term.CharB@
  ;  𝕊𝕩:𝕩=e?𝕩∾e𝕊•term.CharB@
  ;  𝕊𝕩:⟨𝕩⟩
  ; e𝕊𝕩:⊑𝕩∊∾+⟜(↕26)¨"Aa"?𝕩
  ; e𝕊𝕩:𝕩∾e𝕊•term.CharB@
  }

  {𝕊:
    eff←@⋄ch‿ps‿Eff↩Map Input@
    Eff @

    •term.OutRaw clear # clear line and set to start of line
    •term.OutRaw •ToUTF8 opt.prompt
    •term.OutRaw •ToUTF8 ch
    •term.OutRaw e∾"["∾(•Fmt (≠opt.prompt)+ps+1)∾"G"
    •term.Flush@
  }•_while_ 1 @
}
