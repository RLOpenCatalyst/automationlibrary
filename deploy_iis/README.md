deploy_iis Cookbook
===================
Installs IIS and creates environment ready.

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
    <td><tt>['deploy_iis']['docroot']</tt></td>
    <td>string</td>
    <td>Home directory to deploy web apps in IIS</td>
    <td><tt>'C:\inetpub\wwwroot'</tt></td>
  </tr>
  <tr>
    <td><tt>['deploy_iis']['applink'] </tt></td>
    <td>string</td>
    <td>Application source code url</td>
    <td><tt>'https://github.com/RLOpenCatalyst/automationlibrary/raw/master/DemoWebSite1.zip'</tt></td>
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
