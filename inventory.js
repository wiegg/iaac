const fs = require("fs")
// const yaml = require("yaml")

const raw = fs.readFileSync("state.json").toString().split("\n").slice(1).join("\n")

console.log(raw)

const data = JSON.parse(raw)
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

console.log(inventory)

// console.log(yaml.stringify(inventory))

// fs.writeFileSync('inventory.yml', yaml.stringify(inventory))