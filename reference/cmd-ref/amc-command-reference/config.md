---
orphan: true
---
# `config`

The `config` command helps manage the global configuration for the Anbox Management Service (AMS). See {ref}`ref-ams-configuration` for a list of
available configuration items.

    amc config <subcommand>

## Subcommands

The following subcommands are available:

### `set`

Update a single configuration of the AMS.

    amc config set <config_name> <config_value>

### `show`

Display all configuration of the AMS.

    amc config show

### `trust`

Manage trusted clients that can communicate with AMS. You can add or remove client certificates as needed to allow or block communication with AMS.

The `amc config trust` command can be used with three subcommands - `add`, `list` and `remove`.

The `add` command adds a new trusted client that can communicate with the AMS:

        amc config trust add <certificate_path>

The `list` command displays a list of trusted clients:

        amc config trust list --format=table

where `--format` controls the output formatting. `table`, `json` and `yaml` are allowed values while `table` is the default value.

The `remove` command removes a client from the list of trusted clients. You can also use `rm` as an alias.

        amc config trust remove <client_name>

