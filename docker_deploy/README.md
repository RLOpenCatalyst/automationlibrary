Docker_deploy Cookbook
======================

The Docker_deploy Cookbook is used to deploy public or private docker images, run container and send the report to catalyst.

Attributes
----------
### default

`node[:rlcatalyst][:callbackURL]` - 
`node[:rlcatalyst][:registry_server]` -
Use below three attributes to pull private images
`node[:rlcatalyst][:dockerUser]` - Docker Hub User name
`node[:rlcatalyst][:dockerPassword]` - Password for docker hub
`node[:rlcatalyst][:dockerEmailId]` - registered email for docker hub
`node[:rlcatalyst][:dockerImage]` - docker image
`node[:rlcatalyst][:imageTag]` - docker images tag
`node[:rlcatalyst][:containerPort]` - Port inside container to bidn with host
`node[:rlcatalyst][:hostPort]` - Port on host machine to  bind with docker container
`node[:rlcatalyst][:containerId]` - Name of the container to run
`node[:rlcatalyst][:applicationNodeIP] ` - IP address of the node on which docker_deploy cookbook to be run to deploy name.
`node[:rlcatalyst][:upgrade]` - set this boolean value to true to upgrade the the container with new image. Default value is false
`node[:rlcatalyst][:ContainerVolumes]` - Provide the volumes to be attached. Format :`'/hostbits:/bits', '/more-hostbits:/more-bits'` 
`node[:rlcatalyst][:applicationStatus]` - It will be used while sending the deployment status to catalyst.







<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['docker_deploy']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### docker_deploy::default

Include `docker_deploy` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[docker_deploy::default]"
  ]
}
```

## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
