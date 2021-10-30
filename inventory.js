const fs = require("fs")
const yaml = require("yaml")

const raw = fs.readFileSync("state.json")

// remove first line by github runner
let content = raw.toString().split('\n')
content.shift()
content = content.join('\n')

const data = JSON.parse(content)
ip_list = {}

data["resources"].forEach(i => {
  if (i["type"] == "hcloud_server" && i["mode"] == "managed") {
    i["instances"].forEach(s => {
      ip_list[s["attributes"]["ipv4_address"]] = null
    })
  }
});

const inventory = {
  nodes: {
    hosts: ip_list
  }
}

console.log(yaml.stringify(inventory))

fs.writeFileSync('inventory.yml', yaml.stringify(inventory))