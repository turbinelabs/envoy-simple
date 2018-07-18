#!/bin/bash

# Copyright 2018 Turbine Labs, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

if [ -n "$ENVOY_LOG_LEVEL" ]; then
  ENVOY_ARGS="$ENVOY_ARGS -l $ENVOY_LOG_LEVEL"
fi

if [ -n "$ENVOY_BASE_ID" ]; then
  ENVOY_ARGS="$ENVOY_ARGS --base-id $ENVOY_BASE_ID"
fi

if [ -n "$ENVOY_LIGHTSTEP_ACCESS_TOKEN" ]; then
  # if the token file is unset, default it to /etc/envoy/lightstep-access-token.
  # this simplifies templating logic to avoid checking for either the token or
  # token_file being set
  if [ -z "${ENVOY_LIGHTSTEP_ACCESS_TOKEN_FILE}" ]; then
    ENVOY_LIGHTSTEP_ACCESS_TOKEN_FILE="/etc/envoy/lightstep-access-token"
  fi
  echo $ENVOY_LIGHTSTEP_ACCESS_TOKEN > $ENVOY_LIGHTSTEP_ACCESS_TOKEN_FILE
fi

/usr/local/bin/envtemplate \
  -in /etc/envoy/bootstrap.conf.tmpl \
  -out /etc/envoy/bootstrap.conf

echo /usr/local/bin/envoy -c /etc/envoy/bootstrap.conf $ENVOY_ARGS
/usr/local/bin/envoy -c /etc/envoy/bootstrap.conf $ENVOY_ARGS
