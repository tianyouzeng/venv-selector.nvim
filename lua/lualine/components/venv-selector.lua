local M = require('lualine.component'):extend()
local system = require('venv-selector.system')

local default_opts = {
  icon = '',
  color = { fg = '#CDD6F4' },
  auto_hide = true,
  on_click = function()
    require('venv-selector').open()
  end,
}

function M:init(options)
  M.super.init(self, options)
  self.options = vim.tbl_deep_extend('keep', self.options or {}, default_opts)
end

function M:update_status()
  local venv = require('venv-selector').get_active_venv()
  if self.options.auto_hide and vim.bo.filetype ~= 'python' then
    return ''
  end
  if venv then
    local venv_parts = vim.fn.split(venv, '/')
    if system.get_path_separator() == '\\' then
      venv_parts = vim.fn.split(venv_parts[#venv_parts], '\\')
    end
    local venv_name = venv_parts[#venv_parts]
    return venv_name
  else
    return 'Select Venv'
  end
end

return M
