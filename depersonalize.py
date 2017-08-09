import json
from pprint import pprint

with open('./Better Touch Tool Preferences.json') as data_file:
    data = json.load(data_file)

content = data["BTTPresetContent"]

for element in content:
    if element["BTTAppName"] == "Global":
        count = len(element["BTTTriggers"]) - 1
        for name in reversed(element["BTTTriggers"]):
            if "BTTPredefinedActionName" in name:
                if name["BTTPredefinedActionName"] == "Insert / Paste Custom Text":
                    del element["BTTTriggers"][count]
            count -= 1

with open('./BTT-public.json', "w") as out_file:
    json.dump(data, out_file)
