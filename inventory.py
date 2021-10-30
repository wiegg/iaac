import json
import yaml

with open('state.json') as f:
  raw = f.read()
  data = json.loads(raw)

ip_list = {}

for i in data["resources"]:
  if i["type"] == "hcloud_server" and i["mode"] == "managed":
    for s in i["instances"]:
      ip_list[s["attributes"]["ipv4_address"]] = None

inventory = dict(
  nodes = dict(
    hosts = ip_list
))

print(yaml.dump(inventory))