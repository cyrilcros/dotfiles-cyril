#!/bin/bash
# Append source line to ~/.bashrc if not already present
if ! grep -q 'bashrc_additions' ~/.bashrc; then
    echo '' >> ~/.bashrc
    echo '# Source chezmoi-managed bashrc additions' >> ~/.bashrc
    echo '[[ -f ~/.bashrc_additions ]] && source ~/.bashrc_additions' >> ~/.bashrc
fi
