vim_colors "Today" do
  author "Edward Loveall"
  notes  "Based on Tomorrow for Textmate"

  reset      true
  background :light

  white       =   "fff"
  black       =   "222"
  foreground  =   "4d4d4c"
  background  =   "F4F1ED"
  selection   =   "d6d6d6"
  line        =   "efefef"
  comment     =   "8e908c"
  red         =   "c82829"
  orange      =   "f5871f"
  yellow      =   "eab700"
  green       =   "718c00"
  aqua        =   "3e999f"
  blue        =   "4271ae"
  purple      =   "8959a8"
  window      =   "efefef"
  none        =   "none"

  # Vim
  Normal        foreground, background
  NonText       selection
  SpecialKey    selection
  Search        foreground, yellow
  TabLine       foreground, background
  StatusLine    window, yellow
  StatusLineNC  window, foreground
  VertSplit     window, window
  Visual        none, selection
  Directory     blue
  ModeMsg       green
  MoreMsg       green
  Question      green
  WarningMsg    red
  MatchParen    none, selection
  Folded        comment, background
  FoldColumn    background
  LineNr        foreground
  ErrorMsg      white, red
  vimCommand    red

  # Standard
  Comment       comment
  Todo          comment, background
  Title         comment
  Identifier    red
  Statement     red
  Conditional   foreground
  Repeat        foreground
  Structure     purple
  Function      blue
  Constant      orange
  String        green
  Special       foreground
  PreProc       purple
  Operator      aqua
  Type          yellow
  Define        purple
  Include       blue

  # White space
  ExtraWhitespace   none, selection
  NonText           selection
  SpecialKey        selection
  
  # C
  cType           yellow
  cStorageClass   purple
  cConditional    purple
  cRepeat         purple
  
  # PHP
  phpVarSelector      red
  phpKeyword          purple
  phpRepeat           purple
  phpConditional      purple
  phpStatement        purple
  phpMemberSelector   foreground
  
  # Ruby
  rubySymbol                  green
  rubyConstant                yellow
  rubyAttribute               blue
  rubyInclude                 blue
  rubyLocalVariableOrMethod   orange
  rubyCurlyBlock              orange
  rubyStringDelimiter         green
  rubyInterpolationDelimiter  orange
  rubyConditional             purple
  rubyRepeat                  purple
  
  # Python
  pythonInclude       purple
  pythonStatement     purple
  pythonConditional   purple
  pythonFunction      blue
  
  # JavaScript
  javaScriptBraces        foreground
  javaScriptFunction      purple
  javaScriptConditional   purple
  javaScriptRepeat        purple
  javaScriptNumber        orange
  javaScriptMember        orange
  
  # HTML
  htmlTag         red
  htmlTagName     red
  htmlArg         red
  htmlScriptTag   red
  
  # CSS
  cssIdentifier   green
  cssUIAttr       orange
  cssBraces       foreground
  cssMedia        purple
  cssMediaType    green

  # SASS
  sassMixinName     blue
  sassCssAttribute  orange
  sassProperty      orange

  link :sassId, :sassIdChar, to: :cssIdentifier
  
  # Diff
  diffAdded     green
  diffRemoved   red
 
end

