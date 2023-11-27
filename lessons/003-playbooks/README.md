# Lesson 03: Playbooks

## Challenges

### Scenario A

For your development teams you provide a devops platform which enables them to spawn their own virtual machines for testing their source code. However the platform lacks the capability to notice when a host is ready to be used. Since the developers use both linux and windows targets, the time until a host is ready varies drastically. Your team decides that it's a fast and easy solution to run an ansible playbook at the end of the provisiong phase on your CI server. The playbook is run every 10 seconds until the pipeline is successful which would be the case when all ping tasks in the playbook are successful.

After you set the pipeline up you notice that no pipeline ever becomes successful. You inspect the output of the pipeline and notice that there is always one task that fails, no matter what since `win_ping` only works with windows hosts and `ping` only works with linux hosts.

#### Task

Seperate the playbook into two playbooks, one for linux and one for windows. Ensure that each playbook only runs for the respective host group so that all tasks in a playbook are successful.

#### Hint

You can use the virtual machines from Vagrant to run your playbooks against them.

## Additional Material

### Guides

- [Ansible playbooks](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html)
- [Creating a playbook](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html)

### References

- [ansible.builtin.ping](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/ping_module.html)
- [ansible.windows.win_ping](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_ping_module.html)
- [community.windows](https://docs.ansible.com/ansible/latest/collections/community/windows/index.html)
