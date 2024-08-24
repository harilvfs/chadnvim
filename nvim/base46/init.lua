local M = {}
local g = vim.g
local uiconfig = require("nvconfig").ui
local opts = require("nvconfig").base46
local cache_path = vim.g.base46_cache

local integrations = {
  "blankline",
  "cmp",
  "defaults",
  "devicons",
  "git",
  "lsp",
  "mason",
  "nvcheatsheet",
  "nvdash",
  "nvimtree",
  "statusline",
  "syntax",
  "treesitter",
  "tbline",
  "telescope",
  "whichkey",
}

for _, value in ipairs(opts.integrations) do
  table.insert(integrations, value)
end

M.get_theme_tb = function(type)
  local name = uiconfig.theme or opts.theme
  local present1, default_theme = pcall(require, "base46.themes." .. name)
  local present2, user_theme = pcall(require, "themes." .. name)

  if present1 then
    return default_theme[type]
  elseif present2 then
    return user_theme[type]
  else
    error "No such theme!"
  end
end

M.merge_tb = function(...)
  return vim.tbl_deep_extend("force", ...)
end

local change_hex_lightness = require("base46.colors").change_hex_lightness

-- turns color var names in hl_override/hl_add to actual colors
-- hl_add = { abc = { bg = "one_bg" }} -> bg = colors.one_bg
M.turn_str_to_color = function(tb)
  local colors = M.get_theme_tb "base_30"
  local copy = vim.deepcopy(tb)

  for _, hlgroups in pairs(copy) do
    for opt, val in pairs(hlgroups) do
      if opt == "fg" or opt == "bg" or opt == "sp" then
        if not (type(val) == "string" and val:sub(1, 1) == "#" or val == "none" or val == "NONE") then
          hlgroups[opt] = type(val) == "table" and change_hex_lightness(colors[val[1]], val[2]) or colors[val]
        end
      end
    end
  end

  return copy
end

M.extend_default_hl = function(highlights, integration_name)
  local polish_hl = M.get_theme_tb "polish_hl"

  -- polish themes
  if polish_hl and polish_hl[integration_name] then
    highlights = M.merge_tb(highlights, polish_hl[integration_name])
  end

  -- transparency
  if uiconfig.transparency or opts.transparency then
    local glassy = require "base46.glassy"

    for key, value in pairs(glassy) do
      if highlights[key] then
        highlights[key] = M.merge_tb(highlights[key], value)
      end
    end
  end

  local hl_override = uiconfig.hl_override or opts.hl_override
  local overriden_hl = M.turn_str_to_color(hl_override)

  for key, value in pairs(overriden_hl) do
    if highlights[key] then
      highlights[key] = M.merge_tb(highlights[key], value)
    end
  end

  return highlights
end

M.get_integration = function(name)
  local highlights = require("base46.integrations." .. name)
  return M.extend_default_hl(highlights, name)
end

-- convert table into string
M.tb_2str = function(tb)
  local result = ""

  for hlgroupName, v in pairs(tb) do
    local hlname = "'" .. hlgroupName .. "',"
    local hlopts = ""

    for optName, optVal in pairs(v) do
      local valueInStr = ((type(optVal)) == "boolean" or type(optVal) == "number") and tostring(optVal)
        or '"' .. optVal .. '"'
      hlopts = hlopts .. optName .. "=" .. valueInStr .. ","
    end

    result = result .. "vim.api.nvim_set_hl(0," .. hlname .. "{" .. hlopts .. "})"
  end

  return result
end

M.str_to_cache = function(filename, str)
  -- Thanks to https://github.com/nullchilly and https://github.com/EdenEast/nightfox.nvim
  -- It helped me understand string.dump stuff
  local lines = "return string.dump(function()" .. str .. "end, true)"
  local file = io.open(cache_path .. filename, "wb")

  if file then
    file:write(loadstring(lines)())
    file:close()
  end
end

M.compile = function()
  if not vim.uv.fs_stat(vim.g.base46_cache) then
    vim.fn.mkdir(cache_path, "p")
  end

  M.str_to_cache("term", require "base46.term")

  local all_str = ""

  for _, name in ipairs(integrations) do
    local hl_str = M.tb_2str(M.get_integration(name))

    if name == "defaults" then
      hl_str = "vim.o.tgc=true vim.o.bg='" .. M.get_theme_tb "type" .. "' " .. hl_str
    end

    if opts.compile_onefile then
      all_str = all_str .. hl_str
    else
      M.str_to_cache(name, hl_str)
    end
  end

  if opts.compile_onefile then
    M.str_to_cache("all", all_str)
  end
end

M.load_all_highlights = function()
  require("plenary.reload").reload_module "base46"
  M.compile()

  if not opts.compile_all then
    for _, name in ipairs(integrations) do
      dofile(vim.g.base46_cache .. name)
    end
  else
    dofile(vim.g.base46_cache .. "all")
  end

  -- update blankline
  pcall(function()
    require("ibl").update()
  end)
end

M.override_theme = function(default_theme, theme_name)
  local changed_themes = uiconfig.changed_themes or opts.changed_themes
  return M.merge_tb(default_theme, changed_themes.all or {}, changed_themes[theme_name] or {})
end

--------------------------- user functions ----------------------------------------------------------
M.toggle_theme = function()
  local themes = uiconfig.theme_toggle or opts.theme_toggle

  if opts.theme ~= themes[1] and opts.theme ~= themes[2] then
    vim.notify "Set your current theme to one of those mentioned in the theme_toggle table (chadrc)"
    return
  end

  g.icon_toggled = not g.icon_toggled
  g.toggle_theme_icon = g.icon_toggled and "   " or "   "

  if uiconfig.theme ~= nil then
    uiconfig.theme = (themes[1] == uiconfig.theme and themes[2]) or themes[1]
  else
    opts.theme = (themes[1] == opts.theme and themes[2]) or themes[1]
  end

  local chadrc = dofile(vim.fn.stdpath "config" .. "/lua/chadrc.lua")
  local old_theme = (chadrc.ui and chadrc.ui.theme) or chadrc.base46.theme

  require("nvchad.utils").replace_word('theme = "' .. old_theme, 'theme = "' .. opts.theme)
  M.load_all_highlights()
end

M.toggle_transparency = function()
  opts.transparency = not opts.transparency
  M.load_all_highlights()

  local old = dofile(vim.fn.stdpath "config" .. "/lua/chadrc.lua").transparency
  local new = "transparency = " .. tostring(opts.transparency)
  require("nvchad.utils").replace_word("transparency = " .. tostring(old), new)
end

return M
