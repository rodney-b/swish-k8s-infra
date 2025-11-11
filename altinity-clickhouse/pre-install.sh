#!/bin/bash
set -euo pipefail
# To ensure bash errors loudly
# For example, the following would fail silently without the trap: `password=$(base64 < /dev/urandom | head -c 41)`
# Yes, I learned this the hard way.
trap 'echo "error on line $LINENO: \`$BASH_COMMAND\` exited with status $?" >&2' ERR

namespace="swish-analytics"
kubectl create namespace "${namespace}" || true
kubectl config set-context --current --namespace="${namespace}"

users=(admin otel_exporter hyperdx)
secretName="clickhouse-users"

kubectl create secret generic "${secretName}" || true
echo "Secret $secretName created"

# Loop through each user and add them to the secret if they don't already exist
for user in "${users[@]}"; do
	echo "Adding user $user..."
	# Generate a random base64 encoded 44-character password
	password=$(head -c 44 /dev/urandom | base64)
	echo "Generated password for $user"
	# Hash the password using SHA-256 and then remove space, dash, and newline characters
	hashedPassword=$(echo -n "$password" | sha256sum | tr -d ' -\n')

	echo "Checking if users exists"
	if [[ -n $(kubectl get secret "$secretName" -o jsonpath="{.data.$user}" 2>/dev/null) ]]; then
		echo "Skipping existing user '$user'"
		continue
	fi

	kubectl patch secret "$secretName" \
		--type merge \
		-p "{\"stringData\":{\"$user\":\"$hashedPassword\", \"${user}_plain\":\"$password\"}}"
	echo "Added user $user to secret"
done


# PS. In case you're wondering why the command `password=$(base64 < /dev/urandom | head -c 41)` fails:
# Because it reads an infinite stream from /dev/urandom. `head -c 41` takes 41 bytes and then exits, closing its pipe.
# The upstream base64 is still trying to write, hits a SIGPIPE, and exits non-zero.
# With pipefail on, the pipeline’s status is that non-zero, so -e aborts the script.
# Bash does not print a message for `-e` exits; unless a command itself emits an error, you see nothing—so it looks “silent.”