#deploy_rlcatalyst Cookbook

It will deploy the catalyst application after installing mongodb, nodejs.


#dependency Cookbooks:

app_data_handler, git:
java8, git:
unzip, git:

#Platforms:
ubuntu 14.04


#Usage

This cookbook contains only one recipe.

Run this cookbook along with git, nodejs, mongodb3 cookbook. 

```json
{
  "name":"deploy_rlcatalst",
  "run_list": [
    "recipe[git]",
    "recipe[nodejs]",
    "recipe[mongodb3]",
    "recipe[deploy_rlcatalyst]"
  ]
}
```

Open port 3001 to access the catalyst application.

After successful execution, access the catalyst at '<node_IP_address>:3001'.


# Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:nodejs][:repo_url]</tt></td>
    <td>Boolean</td>
    <td> Catalyst Source Code URL</td>
    <td><tt>https://github.com/RLOpenCatalyst/core.git</tt></td>
  </tr>

<tr>
    <td><tt>[:nodejs][:source_location]</tt></td>
    <td>String</td>
    <td>App installation location </td>
    <td><tt>/home/user/catalyst</tt></td>
  </tr>




</table>


