app_data_handler Cookbook
=========================
It is used to POST the application data to catalyst App deploy API.

Requirements
------------

Platforms:
 Ubuntu 14.04 and later
 centos 7


Attributes
----------

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:app_data_handler][:catalystCallbackUrl]</tt></td>
    <td>string</td>
    <td> The callback url of catalyst, where the applicaition deploy data has to be POST'ed. </td>
    <td><tt> nil </tt></td>
  </tr>
  <tr>
    <td><tt>['app_data_handler']['app']['applicationName']</tt></td>
    <td>string</td>
    <td> Application name </td>
    <td><tt> nil </tt></td>
  </tr>
  <tr>
    <td><tt>['app_data_handler']['app']['applicationVersion']</tt></td>
    <td>string</td>
    <td> Artifact version in nexus repo </td>
    <td><tt> nil </tt></td>
  </tr>
  <tr>
    <td><tt>['app_data_handler']['app']['applicationInstanceName']</tt></td>
    <td>string</td>
    <td> Application name </td>
    <td><tt> nil </tt></td>
  </tr>
  <tr>
    <td><tt>['app_data_handler']['app']['applicationNodeIP']</tt></td>
    <td>string</td>
    <td> Node's public IP address which should be present as a instance inside catalyst. </td>
    <td><tt> nil </tt></td>
  </tr>
  <tr>
    <td><tt>['app_data_handler']['app']['envId'] </tt></td>
    <td>string</td>
    <td> The environment where the application has been deploy. ex: Dev or QA or Prod </td>
    <td><tt> nil </tt></td>
  </tr>
  

  <tr>
    <td><tt>['app_data_handler']['app']['containerId'] </tt></td>
    <td>string</td>
    <td> If docker repo is choosen for the deployment, chef-client passes the Docker container ID. </td>
    <td><tt> nil </tt></td>
  </tr>
  <tr>
    <td><tt> ['app_data_handler']['app']['applicationType'] </tt></td>
    <td>string</td>
    <td> Artifact type, ex: binary, source, package. </td>
    <td><tt> nil </tt></td>
  </tr>

</table>

Usage
-----
In data handler recipe of the cookbook, assign the values to attributes and then call app_data_handler recipe. 

```
ruby_block "Update App data" do
  block do
    node.default['app_data_handler']['catalystCallbackUrl'] = node['app_data_handler']['catalystCallbackUrl']
    node.default['app_data_handler']['app']['applicationName'] = repoid
    node.default['app_data_handler']['app']['applicationVersion'] = node["rlcatalyst"]["version"]
    node.default['app_data_handler']['app']['applicationType'] = "Package"
    node.default['app_data_handler']['app']['containerId'] = "NA"
    node.default['app_data_handler']['app']['applicationNodeIP'] = node["rlcatalyst"]["applicationNodeIP"]
    node.default['app_data_handler']['app']['applicationInstanceName'] = repoid
    node.default['app_data_handler']['app']['applicationStatus'] = node["deploy_tomcat_war"]["app_status"]
  end
end

include_recipe "app_data_handler"
```



#### app_data_handler::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `app_data_handler` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[app_data_handler]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
