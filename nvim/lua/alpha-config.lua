local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
 return
end

local dashboard = require("alpha.themes.dashboard")

local header = {
  type = "text",
  val = {
    "                     +::.........           ",
    "                     ;:;;;..........x       ",
    "       ..&+;$;+.     .x;;;;............;.   ",
    "     $;:+$++X;:&Xx    +:;;;;...........:.;+.",
    "    :++++&$$$x$x&;$   x&X$;+;........:...;;;",
    "   .$$xx$&$$$$X$$X$$. .:$&;;;;&...:.;...;.;&",
    " . :XxxX$;x+x:$$$::$.  X+x;x+&$$...:.;...;;;",
    "    &$$&......&$&;$&; ;&&&&;+x;&;...;.;...X.",
    "   :&&$&......++&&....;;;..+;x.;X;.......$;;",
    "  ..x.x:$&...;;;:x...;;;;;;X.: .; x....;.;;;",
    " ...;:XX;&&$$:.$X&&.;;.;&X$x&&;   .X....;.;;",
    "...X$+;;x$++x.;&.$.&...::;:::::;.   ...:;x;$",
    ".;:;$;;;+++xx&X:+$&:...:::X::::::.   X.;;;;;",
    "xx;:$;;;x.X. ...:XX+...::;::::::::.  .&..;&;",
    "X;;:;X;$$   +...:;:;.:::::&$:;:::::    ..;X;",
    ";x&X;;;$    .;:..::  .+.:$.x:$:x;:::   ...;&",
    ".;+.;:;       $;&.    ...;$X.&$:$;:;:X x.;; ",
    ";; ;X        &.::.    ....:$:$$$$$$$;$. ..; ",
    ";..          ..;:. x;.....:.:::::;;::X:::.; ",
    "              .::.;.:;.:..;+::::;::::;:&x...",
    "             ..;:.:+.:.$..::.:+;:::::;;:....",
    "            +.$X++..;:$;:$XX$$;X:::;$:;:&XXX",
    "           ;:..::;.....:;&..:&:::;;X;+XXXXxx",
    "            X.&$.........X..;:::::;&;XXXXXxx",
    "           ...;.;..X:.;;;:.:;;$XXXXXXXXXxxxx",
    "           ..;;.....;::$.;;;..:;XXXXXXxxxxx+",
    "             .....:;::x::;&XX$.x;XXXxxxxx+++",
    "             ...;..:;;+:X:XXXXXXXXXxxxxx++++",
    "            :..;;$...x::;$XXXX.    .::+++++;",
  },
  opts = {
    position = "center",
    hl = "Type",
  },
}
 dashboard.section.buttons.val = {
   dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
   dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
   dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
   dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
   dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
   dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
  local handle = io.popen("fortune -s") -- -s = short fortunes only, keeps it tidy
  local fortune = handle:read("*a")
  handle:close()
  -- split into a table of lines, trimming empty trailing lines
  local lines = {}
  for line in fortune:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end
  return lines
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts = {
  position = "center",
  hl = "Comment", -- pick whatever highlight group you want
}

dashboard.section.header.val = header.val
dashboard.section.header.opts = header.opts
dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
