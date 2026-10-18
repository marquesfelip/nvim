--- Deixa arquivos e pastas ocultos (nome começando com `.`) levemente
---  acinzentados, para ficar mais fácil de diferenciá-los.
---
--- Cobre o nvim-tree (via `renderer.highlight_hidden`) e o Telescope (via
---  `require('custom.config.dotfiles').find_files`).

local M = {}

--- Grupo de highlight aplicado nos itens ocultos.
M.hl = 'DotfilesDim'

--- O quanto aproximar a cor do texto da cor de fundo: `0` é o texto normal e
---  `1` é totalmente apagado. Aumente/diminua para deixar o cinza mais
---  forte ou mais suave.
local DIM_RATIO = 0.5

---@param color integer cor RGB no formato 0xRRGGBB
---@param shift integer 16 (R), 8 (G) ou 0 (B)
---@return integer
local function channel(color, shift)
  return math.floor(color / 2 ^ shift) % 256
end

--- Mistura `fg` com `bg` e devolve uma cor no formato `#rrggbb`.
---@param fg integer
---@param bg integer
---@param ratio number
---@return string
local function blend(fg, bg, ratio)
  local hex = {}
  for _, shift in ipairs { 16, 8, 0 } do
    local value = channel(fg, shift) * (1 - ratio) + channel(bg, shift) * ratio
    hex[#hex + 1] = string.format('%02x', math.floor(value))
  end
  return '#' .. table.concat(hex)
end

--- (Re)define o cinza a partir do colorscheme atual. Se o tema mudar, isso é
---  chamado de novo (ver o autocommand no final do arquivo).
function M.setup()
  local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })

  vim.api.nvim_set_hl(0, M.hl, {
    fg = blend(normal.fg or 0xcccccc, normal.bg or 0x000000, DIM_RATIO),
  })

  -- Grupos que o nvim-tree usa para nós "hidden"; veja `renderer.highlight_hidden`.
  vim.api.nvim_set_hl(0, 'NvimTreeHiddenFileHL', { link = M.hl })
  vim.api.nvim_set_hl(0, 'NvimTreeHiddenFolderHL', { link = M.hl })
end

--- Um caminho é oculto quando algum de seus componentes começa com `.`, então
---  o conteúdo de uma pasta oculta também conta como oculto.
---@param path string
---@return boolean
function M.is_hidden(path)
  return path:sub(1, 1) == '.' or path:find('/%.') ~= nil
end

--- Comando de busca que inclui arquivos ocultos, mas ignora o diretório `.git`.
---@return string[]
local function hidden_find_command()
  if vim.fn.executable 'rg' == 1 then
    return { 'rg', '--files', '--color=never', '--hidden', '--glob=!.git/' }
  elseif vim.fn.executable 'fd' == 1 then
    return { 'fd', '--type', 'f', '--color=never', '--hidden', '--exclude', '.git' }
  elseif vim.fn.executable 'fdfind' == 1 then
    return { 'fdfind', '--type', 'f', '--color=never', '--hidden', '--exclude', '.git' }
  end
  return { 'find', '.', '-type', 'f', '-not', '-path', '*/.git/*' }
end

--- Faz uma entrada do Telescope ser exibida em cinza, mantendo a cor do ícone.
---@param entry table
---@return table
function M.dim_entry(entry)
  local display = entry.display
  if type(display) ~= 'function' then
    return entry
  end

  entry.display = function(self, picker)
    local text, highlights = display(self, picker)
    if not text then
      return text, highlights
    end

    -- `highlights` é uma lista de `{ { col_inicial, col_final }, grupo }`. O
    --  ícone, quando existe, ocupa o começo da linha: começamos o cinza onde
    --  ele termina para não apagar a cor do ícone.
    --
    --  Atenção: o Telescope soma o prefixo da linha (`> `) às duas pontas do
    --  range, então não dá para usar `-1` (fim de linha) aqui — usar `-1`
    --  resultaria numa coluna final negativa e o highlight seria descartado.
    --  Por isso passamos o comprimento do texto exibido.
    local start_col = 0
    if highlights and highlights[1] and highlights[1][1] then
      start_col = highlights[1][1][2]
    end

    highlights = highlights or {}
    table.insert(highlights, { { start_col, math.max(start_col, #text) }, M.hl })

    return text, highlights
  end

  return entry
end

--- `telescope.builtin.find_files` que lista os arquivos ocultos (exceto `.git`)
---  e os mostra em cinza.
---@param opts table? as mesmas opções de `telescope.builtin.find_files`
function M.find_files(opts)
  opts = vim.tbl_extend('force', { find_command = hidden_find_command() }, opts or {})

  local default_entry_maker = require('telescope.make_entry').gen_from_file(opts)

  opts.entry_maker = function(line)
    local entry = default_entry_maker(line)
    if entry and entry.value and M.is_hidden(entry.value) then
      M.dim_entry(entry)
    end
    return entry
  end

  require('telescope.builtin').find_files(opts)
end

-- O cinza é derivado do colorscheme, então recalculamos quando ele mudar.
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('custom-dotfiles', { clear = true }),
  callback = M.setup,
})
M.setup()

return M
