# deploy_tomcat_war-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.


# action steps
1. install tomcat
2. download the nexus artifact
3. unzip the war file
4. copy the folder in specific folder
5. start the tomcat7 service
6. Use the app_data_handler to post the date to D4D.(in the next versions)
## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['deploy_tomcat_war']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### deploy_tomcat_war::default

Include `deploy_tomcat_war` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[deploy_tomcat_war::default]"
  ]
}
```

## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
