import os
import json
import pandas as pd

file_path = os.path.expanduser("~/DS2002-json-practice/data/schacon.repos.json")

with open(file_path, 'r') as file:
    data = json.load(file)

repo_list = []
for repo in data[:5]:
    name = repo['name']
    url = repo ['html_url']
    updated_at = repo['updated_at']
    visibility = repo['visibility']
    repo_list.append([name, url, updated_at, visibility])

df = pd.DataFrame(repo_list)
df.to_csv('chacon.csv', index=False, header = False)
