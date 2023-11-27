# Lesson 01: Inventories

## Challenges

### Scenario A

During your last production rollout you had an outtage which made the infrastructure unusable for about half an hour which resulted in unhappy customers. After your team resolved the outtage, you came together for a post-mortem meeting. In the analysis of the outtage you noticed that the static cache service broke down due to a new feature that has been added. Naturally your development teams don't use caches since they change a lot of things often during the development cycle. To ensure this problem does not happen again, you decided to create a staging environment which mirros the production environment. This staging environment will be used to test production rollouts before they are applied to the production environment.

#### Task

Create an inventory for the staging environment. All hosts in the staging environment use a `-stage` suffix. Also make sure that the `inventory_environment` variable is set to `staging` and that all windows hosts use the `inventory_cache_warmup_time` variable which is set to `120`.

### Scenario B

When the outtage occured it took about 7 minutes before anyone noticed that some customers had problems using the infrastructure. Mainly because the support team was swarmed with support requests. Because of this your product manager got a bit nervous for future rollouts. He asks you what you can do about the speed of noticing an outtage. Your team decides it's best to roll out prometheus exporters to all hosts.

#### Task

- Linux additional opened ports: `9100`
- Windows additional opened ports: `9182`

Update the **group_vars** to ensure the firewalls for all hosts are configured to have the respective port for their OS opened but **do not** have the port from another OS opened (e.g. linux hosts should not have the port for windows open). Also ensure that the three ports (`22`, `80` and `443`) which are already open, stay open.

## Additional Material

### Guides

- [How to build your inventory](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html)
