deploy_iis Cookbook
===================
Installs IIS and creates installs dotNet application.


Requirements
------------
OS Support: 
windows.


Dependencies: 
-------------
iis
git
windows


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
    <td><tt>['deploy_dotNet']['gitRepo'] </tt></td>
    <td>String</td>
    <td>git repo of dotnet application.</td>
    <td><tt>git://github.com/RLIndia/cms.git</tt></td>
  </tr>
</table>

Usage
-----
Just include `deploy_iis` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[deploy_iis]"
  ]
}
```

