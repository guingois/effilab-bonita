#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

test_vn () {
  test -v $1 && test -n "${!1}" && return 0
  echo "\$$1 cannot be unset or blank" >&2
  return 1
}

test_vn_many () {
  local result=true
  local key

  for key in "$@"; do
    test_vn "$key" || result=false
  done

  [ "$result" = true ]
}

test_vn_many \
  APP \
  DOCS_SFTP_HOST \
  DOCS_SFTP_PORT \
  DOCS_SFTP_USER \
  DOCS_SFTP_PRIVATE_KEY

if [ -n "${1:-}" ]
then
  DOC_DIRECTORIES=("$@")
else
  echo "Pass at least one directory as argument" >&2
  exit 1
fi

WORKDIR="$(pwd)"
TMPDIR="$(mktemp -d)"

trap 'cd "$WORKDIR" && rm -rfv "$TMPDIR"' EXIT

DOCS_SFTP_PASS=
DOCS_SFTP_KEY_PATH="$TMPDIR/key"
echo "$DOCS_SFTP_PRIVATE_KEY" > "$DOCS_SFTP_KEY_PATH"
chmod 600 "$DOCS_SFTP_KEY_PATH"

DOCS_PATH="$TMPDIR/$APP"

mkdir "$DOCS_PATH"
cp -a "${DOC_DIRECTORIES[@]}" "$DOCS_PATH"
cd "$TMPDIR"

lftp <<EOF
set cmd:interactive false;
set cmd:fail-exit true;
set net:timeout 10;
set net:max-retries 1;
set sftp:auto-confirm true;
set sftp:connect-program "ssh -a -x -i $DOCS_SFTP_KEY_PATH -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
open sftp://$DOCS_SFTP_USER:$DOCS_SFTP_PASS@$DOCS_SFTP_HOST:$DOCS_SFTP_PORT;
mirror -eRL --verbose=1 $APP nginx/;
exit;
EOF
