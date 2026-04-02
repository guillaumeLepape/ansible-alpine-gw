alias i := install
alias r := run
alias c := check
alias ve := vault_edit
alias vv := vault_view

install:
    ansible-galaxy collection install -r requirements.yml

run:
    ansible-playbook -i inventory.ini playbook.yml

check:
    uv run pre-commit run -a

vault_edit:
    ansible-vault edit group_vars/alpine_gw/vault.yml

vault_view:
    ansible-vault view group_vars/alpine_gw/vault.yml
