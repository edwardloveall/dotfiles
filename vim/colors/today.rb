vim_colors "Today" do
  author "Edward Loveall"
  notes  "These colors are based off Tomorrow"

  reset      true
  background :light

  foreground = "4d4d4c"
  background = "F4F1ED"
  selection = "d6d6d6"
  line = "efefef"
  comment = "8e908c"
  red = "c82829"
  orange = "f5871f"
  yellow = "eab700"
  green = "718c00"
  aqua = "3e999f"
  blue = "4271ae"
  purple = "8959a8"
  window = "efefef"
  none = "none"

  # Vim highlighting
  Normal        foreground, background
  LineNr        foreground, none, gui: 'bold'
  NonText       selection, none
  SpecialKey    selection, none
  Search        foreground, yellow
  TabLine       foreground, background
  StatusLine    window, yellow
  StatusLineNC  window, foreground
  VertSplit     window, window
  Visual        none, selection
  Directory     blue, none
  ModeMsg       green, none
  MoreMsg       green, none
  Questio       green, none
  WarningMsg    red, none            
  MatchParen    none, selection
  Folded        comment, background
  FoldColumn    none, background
  vimCommand    red, none
  
  # Standard highlighting
  Comment       comment, none
  Todo          comment, background
  Title         comment, none
  Identifier    red, none
  Statement     foreground, none
  Conditional   foreground, none
  Repeat        foreground, none
  Structure     purple, none
  Function      blue, none
  Constant      orange, none
  String        green, none
  Special       foreground, none
  PreProc       purple, none
  Operator      aqua, none
  Type          yellow, none
  Define        purple, none
  Include       blue, none

  # C
  ctype           yellow, none
  cStorageClass   purple, none
  cConditional    purple, none
  cRepeat         purple, none

  # PHP
  phpVarSelector      red, none
  phpKeyword          purple, none
  phpRepeat           purple, none
  phpConditional      purple, none
  phpStatement        purple, none
  phpMemberSelector   foreground, none 

  # Ruby
  rubySymbol                  green, none
  rubyConstant                yellow, none
  rubyAttribute               blue, none
  rubyInclude                 blue, none
  rubyLocalVariableOrMethod   orange, none
  rubyCurlyBlock              orange, none
  rubyStringDelimiter         green, none
  rubyInterpolationDelimiter  orange, none
  rubyConditional             purple, none
  rubyRepeat                  purple, none

  # Python
  pythonInclude       purple, none
  pythonStatement     purple, none
  pythonConditional   purple, none
  pythonFunction      blue, none
  
  # JavaScript
  javaScriptBraces        foreground, none
  javaScriptFunction      purple, none
  javaScriptConditional   purple, none
  javaScriptRepeat        purple, none
  javaScriptNumber        orange, none
  javaScriptMember        orange, none

  # HTML
  htmlTag         red, none
  htmlTagName     red, none
  htmlArg         red, none
  htmlScriptTag   red, none
  
  # CSS
  cssTagName      red, none
  cssIdentifier   green, none
  cssColor        aqua, none
  cssBraces       foreground, none
  cssFontAttr     orange, none

  # SASS
  sassId          green, none
  sassClass       green, none
  sassDefinition  red, none

  link :sassId, :sassIDChar, to: :cssIdentifier

  # Diff
  diffAdded     green, none
  diffRemoved   red, none
end
