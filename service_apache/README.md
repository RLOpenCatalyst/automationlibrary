service_apache Cookbook
=======================
Handles the service actions for apache web server


Requirements
------------
Apache server should be installed in the machine.

Usage
-----
#### service_apache::start
Start the apache web server

e.g.
Just include `service_apache::start` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[service_apache::start]"
  ]
}
```
#### service_apache::stop
Stop the apache web server

e.g.
Just include `service_apache::stop` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[service_apache::stop]"
  ]
}
```
#### service_apache::restart
Restart the apache web server

e.g.
Just include `service_apache::restart` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[service_apache::restart]"
  ]
}
```
