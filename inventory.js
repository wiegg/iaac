const fs = require("fs")
const yaml = require("yaml")

const data = JSON.parse(process.env.STATE.toString())

ip_list_nodes = {}
ip_list_redis = {}

data["resources"].forEach(i => {
  if (i["type"] == "hcloud_server" && i["mode"] == "managed") {
    i["instances"].forEach(s => {
      ip_list_nodes[s["attributes"]["ipv4_address"]] = null

      if(s["attributes"]["labels"]["redis"]) {
        ip_list_redis[s["attributes"]["ipv4_address"]] = null
      }
    })
  }
});

const inventory = {
  nodes: {
    hosts: ip_list_nodes
  },
  redis: {
    hosts: ip_list_redis
  }
}

console.log(yaml.stringify(inventory))

fs.writeFileSync('inventory.yml', yaml.stringify(inventory))