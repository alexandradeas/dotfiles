set -g VIRTUALFISH_VERSION 2.5.9

switch (hostname)
	case fedora
		set -g VIRTUALFISH_PYTHON_EXEC /usr/bin/python
		source /home/alexandra/.local/lib/python3.13/site-packages/virtualfish/virtual.fish
	case multivac
		set -g VIRTUALFISH_PYTHON_EXEC /home/alexandra/.local/share/pipx/venvs/virtualfish/bin/python
		source /home/alexandra/.local/share/pipx/venvs/virtualfish/lib/python3.13/site-packages/virtualfish/virtual.fish
		emit virtualfish_did_setup_plugins
end

emit virtualfish_did_setup_plugins
