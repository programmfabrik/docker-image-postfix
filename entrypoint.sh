#!/bin/bash

echo "extracting env..."
envVarPrefix=POSTFIX_CFG_

envVars=$(env | grep $envVarPrefix)

mkdir -p /var/spool/postfix/
mkdir -p /var/spool/postfix/pid

# split env key=value combination in key and value
# apply key and value with postconf
for entry in $envVars; do
    value=${entry#*=}
    key=${entry%"$value"}
    second=$(echo "$key" | sed -e "s+=++g" -e "s+$envVarPrefix++g")

    # we extracted the env vars, let's apply them
    echo -e "executing command: [ postconf \"${second,,} = $value\" || exit 1 ]"
    postconf -e "${second,,} = ${value}" || exit 1
done

cp /postfix/sasl/sasl_passwd /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd

echo "starting postfix with command: $@..."
exec "$@"