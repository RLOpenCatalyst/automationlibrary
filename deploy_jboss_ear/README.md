# deploy_jboss_ear-cookbook
It will be used to deploy any war or ear file in jboss application server and send the application data to the catalyst.

## Supported Platforms

Ubuntu 14.04


attribute 'deploy_jboss_ear/nexusUrl',
  :display_name => "Nexus Repo URL",
  :description => "Mention Nexus url of the repo",
  :default => nil

attribute 'deploy_jboss_ear/catalystCallbackUrl',
  :display_name => "Call Back Url",
  :description => "call back url  for data handler",
  :default => "http://d4d.rlcatalyst.com/app/deploy"


attribute 'deploy_jboss_ear/applicationNodeIP',
  :display_name => "applicationNodeIP",
  :description => "Accepting ip address of instance",
  :default => "NA"

attribute 'deploy_jboss_ear/app_version',
  :display_name => "Application Version",
  :description => "Source code version",
  :default => "NA"



## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['deploy_jboss_ear']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### deploy_jboss_ear::default

Include `deploy_jboss_ear` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[deploy_jboss_ear::default]"
  ]
}
```

## License and Authors

Author:: C Sraddhanand (sraddhanand.chikine@gmail.com)
