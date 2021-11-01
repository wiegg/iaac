const fs = require("fs")
const yaml = require("yaml")

const data = JSON.parse(process.env.STATE.toString())

let ip_list_nodes = {}
let ip_list_db = {}

data["resources"].forEach(i => {
  // only work with servers that are managed by terraform
  if (i["type"] == "hcloud_server" && i["mode"] == "managed") {
    i["instances"].forEach(s => {
      // sort servers by label: node for application servers; db for db servers
      if(s["attributes"]["labels"]["node"]) {
        ip_list_nodes[s["attributes"]["ipv4_address"]] = null
      } 

      if(s["attributes"]["labels"]["db"]) {
        ip_list_db[s["attributes"]["ipv4_address"]] = null
      } 
    })
  }
});

const inventory = {
  nodes: {
    hosts: ip_list_nodes
  },
  db: {
    hosts: ip_list_db
  }
}

console.log(yaml.stringify(inventory))

fs.writeFileSync('inventory.yml', yaml.stringify(inventory))