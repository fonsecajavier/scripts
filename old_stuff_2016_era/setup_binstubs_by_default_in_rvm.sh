#!/bin/bash

# RVM hook for running binstubs by default without prefixing 'bin/' path
hook_file="$rvm_path/hooks/after_use_spring_project"
echo '[[ -f "$PWD/bin/spring" ]] && PATH=$PWD/bin:$PATH' > "$hook_file"
chmod +x "$hook_file"
