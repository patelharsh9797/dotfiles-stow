local M = {}
local package_info = require("package-info")
local snacks = require("snacks")

local actions = {
  { text = "Show dependency versions", fn = package_info.show, fn_name = "package_info.show" },
  { text = "Hide dependency versions", fn = package_info.hide, fn_name = "package_info.hide" },
  { text = "Toggle dependency versions", fn = package_info.toggle, fn_name = "package_info.toggle" },
  { text = "Update dependency on the line", fn = package_info.update, fn_name = "package_info.update" },
  { text = "Delete dependency on the line", fn = package_info.delete, fn_name = "package_info.delete" },
  { text = "Install a new dependency", fn = package_info.install, fn_name = "package_info.install" },
  {
    text = "Install a different dependency version",
    fn = package_info.change_version,
    fn_name = "package_info.change_version",
  },
}

function M.package_info_picker()
  ---@type snacks.picker.ui_select
  snacks.picker.select(actions, {
    prompt = "Package Info Actions",
    format_item = function(item)
      return item.text .. " | " .. item.fn_name
    end,
  }, function(item)
    item.fn()
  end)
end

return M
