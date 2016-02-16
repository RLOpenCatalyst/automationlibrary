# deploy_jboss_ear-cookbook
It will be used to deploy any war or ear file in jboss application server.

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
