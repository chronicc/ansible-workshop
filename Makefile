.DEFAULT_GOAL := help

VAGRANT_PLUGINS :=

ifeq ($(shell cat /etc/lsb-release | grep 'Ubuntu'),)
	ON_UBUNTU := 0
else
	ON_UBUNTU := 1
endif

ifeq ($(shell uname -r | grep -i 'wsl'),)
	ON_WSL := 0
	VAGRANT_PLUGINS += vagrant-libvirt
	VM_PRODIDER := libvirt
else
	ON_WSL := 1
	VM_PROVIDER := hyperv
endif

CMD_VAGRANT := $(shell command -v vagrant 2>/dev/null)

.PHONY: help
help:
	@echo ""
	@if [ "$(ON_UBUNTU)" = "0" ]; then echo ">>> This project ins only supported on Ubuntu"; exit 1; else echo ">>> Detected Ubuntu as operating system"; fi
	@if [ "$(ON_WSL)" = "1" ]; then echo ">>> Detected system running on wsl"; else echo ">>> Detected system running on pure linux"; fi
	@echo ""
	@echo "Usage: make TARGET"
	@echo ""
	@echo "Targets"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: ## Clean up the repository.
	rm -rf .pytest_cache
	rm -rf .vagrant
	rm -rf .venv
	find -iname "*.pyc" -delete

install: install-requirements .venv/bin/activate ## Install requirements for this repository.
	@if [ "$(CMD_VAGRANT)" = "" ]; then echo "No vagrant found. Please install vagrant for your host operatin system."; exit 1; fi
	"$(CMD_VAGRANT)" plugin install vagrant-hostmanager $(VAGRANT_PLUGINS)
	echo "$(VM_PROVIDER)" > ./vagrant_ext/provider.yml

install-requirements: /etc/apt/trusted.gpg.d/hashicorp.gpg /etc/apt/sources.list.d/hashicorp.list
	sudo apt update
	sudo apt install --no-install-recommends -y build-essential python3 python3-dev python3-venv pkg-config libxml2-dev libxslt-dev vagrant

.venv/bin/activate: requirements.lock
	python3 -m venv .venv
	./.venv/bin/pip install -U pip
	./.venv/bin/pip install -r requirements.lock
	./.venv/bin/ansible-galaxy install -r requirements.yml

/etc/apt/trusted.gpg.d/hashicorp.gpg:
	wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/hashicorp.gpg

/etc/apt/sources.list.d/hashicorp.list:
	echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(shell lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
