(howto-delete-instance)=
# How to delete an instance

An instance can be deleted, which will cause any connected user to be disconnected immediately.

## Using the dashboard

In the instances list view, click *Delete* ( ![delete application icon](/images/delete-icon.png) ) and confirm the deletion.

## Using the CLI

Run:

    amc delete <instance_id>

Provide the ID of the instance that you want to delete.

In some cases, it is helpful to delete all instances currently available.
The `amc` command provides a `--all` flag for this, but be careful with this!

    amc delete --all
