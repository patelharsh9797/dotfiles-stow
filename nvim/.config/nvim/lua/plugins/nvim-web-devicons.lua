return {
  enabled = false,
  "nvim-tree/nvim-web-devicons",
  opts = function()
    local devicons = require("nvim-web-devicons")

    local docker_icon, docker_color = devicons.get_icon_color("docker-compose.yml")
    -- local docker_color = "#0db7ed"
    devicons.set_icon({
      ["docker-compose.yml"] = {
        icon = docker_icon,
        color = docker_color,
        name = "DockerComposeDev",
      },
      ["docker-compose.dev.yml"] = {
        icon = docker_icon,
        color = docker_color,
        name = "DockerComposeDev",
      },
      ["docker-compose.prod.yml"] = {
        icon = docker_icon,
        color = docker_color,
        name = "DockerComposeVariant",
      },
      ["docker-compose.base.yml"] = {
        icon = docker_icon,
        color = docker_color,
        name = "DockerComposeVariant",
      },
    })
  end,
}
