service_mysql Cookbook
======================
Handles the service actions of mysql server.

Requirements
------------
Mysql Server should be installed in machine.

Usage
-----
#### service_mysql::start
Start the Mysql Server

e.g.
Just include `service_mysql::start` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[service_mysql::start]"
  ]
}
```

#### service_mysql::stop
Stop the Mysql Server

e.g.
Just include `service_mysql::stop` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[service_mysql::stop]"
  ]
}
```

#### service_mysql::restart
Restart the Mysql Server

e.g.
Just include `service_mysql::restart` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[service_mysql::restart]"
  ]
}
```