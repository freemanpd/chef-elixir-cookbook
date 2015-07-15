elixir Cookbook
===============
This cookbook installs Elixir on CentOS and RedHat operating systems.

Requirements
------------
Chef (12.4.1 or greater)
CentOS 7
Red Hat Enterprise Linux (RHEL) 7

Attributes
----------
default[:elixir][:art_dir] - default installation directory
default[:elixir][:elang_source] - Erlang source code location and version
default[:elixir][:elixir_source] - Elixir source code location and version

Usage
-----
#### elixir::default

Just include `elixir` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[elixir]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: 
Patrick Freeman
