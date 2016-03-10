# deploy_war-cookbook
It will install the any war file.

## Supported Platforms
Ubuntu 14.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['deploy_war']['source_url']</tt></td>
    <td>string</td>
    <td>Artifact url</td>
    <td><tt>nil</tt></td>
  </tr>
  
  <tr>
    <td><tt>['deploy_war']['app_version']</tt></td>
    <td>string</td>
    <td>Artifact version</td>
    <td><tt>nil</tt></td>
  </tr>
  
  <tr>
    <td><tt>['rlcatalyst']['applicationNodeIP']</tt></td>
    <td>string</td>
    <td>Pubilc IP of the node on which is bootstrapped with/ imported on catalyst </td>
    <td><tt>nil</tt></td>
  </tr>

  <tr>
    <td><tt>['deploy_war']['catalystCallbackUrl']</tt></td>
    <td>string</td>
    <td>Callback URL for application data handler </td>
    <td><tt>http://d4d.rlcatalyst.com/app/deploy</tt></td>
  </tr>


</table>

## Usage

You must pass the above attributes to get the cookbook running and displaying the application history.

## Prerequisites: 

The node should have tomcat7 installed.

### deploy_war::default

Include `deploy_war` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[deploy_war::default]"
  ]
}
```
