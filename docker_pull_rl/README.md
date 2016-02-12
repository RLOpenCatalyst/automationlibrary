# docker_pull_rl-cookbook
 It is useful to log into dockerhub. If you pass with attribute value 'image', it will also pull the docker image after loging in with the credentials passed.


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
    <td><tt>[:docker_pull_rl][:user_id]</tt></td>
    <td>string</td>
    <td>Docker hub User ID</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
  <td><tt>[:docker_pull_rl][:password]</tt></td>
    <td>String</td>
    <td>Docker hub login password </td>
    <td><tt>nil</tt></td>
    </tr>
    <tr>
     <td><tt>[:docker_pull_rl][:email]</tt></td>
    <td>string</td>
    <td>Registered password in docker hub</td>
    <td><tt>nil</tt></td>
    </tr> 
</table>

## Usage
update your chef solo provision data in vagrantfaile as mentioned below. 
```
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      docker_pull_rl: {
        user_id: 'Mention Docker hub User Name',
        password: 'Login password ',
        email: 'registered email for docker hub'
        image: 'mentioned the docker private image to  be pulled'
        }
  }
```

### docker_pull_rl::default

Include `docker_pull_rl` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[docker_pull_rl::default]"
  ]
}
```
