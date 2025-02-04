#!/bin/bash

# Prompt for BrowserStack credentials
read -p "Enter your BrowserStack Username: " BROWSERSTACK_USERNAME
read -sp "Enter your BrowserStack Access Key: " BROWSERSTACK_ACCESS_KEY
echo

# Function to add or replace environment variable in .bashrc
add_or_replace_env_var() {
    local var_name=$1
    local var_value=$2
    local file=$3

    if grep -q "^export $var_name=" "$file"; then
        sed -i "s|^export $var_name=.*|export $var_name=$var_value|" "$file"
    else
        echo "export $var_name=$var_value" >> "$file"
    fi
}

# Add or replace the credentials in ~/.bashrc
add_or_replace_env_var "BROWSERSTACK_USERNAME" "$BROWSERSTACK_USERNAME" ~/.bashrc
add_or_replace_env_var "BROWSERSTACK_ACCESS_KEY" "$BROWSERSTACK_ACCESS_KEY" ~/.bashrc

echo "BrowserStack credentials have been set and stored in ~/.bashrc"