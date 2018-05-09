
[//]: # ( Copyright 2018 Turbine Labs, Inc.                                   )
[//]: # ( you may not use this file except in compliance with the License.    )
[//]: # ( You may obtain a copy of the License at                             )
[//]: # (                                                                     )
[//]: # (     http://www.apache.org/licenses/LICENSE-2.0                      )
[//]: # (                                                                     )
[//]: # ( Unless required by applicable law or agreed to in writing, software )
[//]: # ( distributed under the License is distributed on an "AS IS" BASIS,   )
[//]: # ( WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or     )
[//]: # ( implied. See the License for the specific language governing        )
[//]: # ( permissions and limitations under the License.                      )

# envoy-simple

The envoy-simple image is a simple xDS-configured envoy server, which can be
easily configured with environment variables. By default it opens up an admin
port on `0.0.0.0:9999`, and looks for an xDS server on `127.0.0.1:50000`. It
supports the following environment variables:

- **ENVOY_BASE_ID** (default: 0): sets the base ID so that multiple envoys can
  run on the same host
- **ENVOY_NODE_ID** (default: `default-node`): sets the node ID
- **ENVOY_NODE_CLUSTER** (default: `default-cluster`): sets the node cluster
- **ENVOY_NODE_ZONE** (default: `default-zone`): sets the zone in the node locality
- **ENVOY_ADMIN_IP** (default: `0.0.0.0`): sets the admin server listener ip
- **ENVOY_ADMIN_PORT** (default: `9999`): sets the admin server listener port
- **ENVOY_ADMIN_LOG** (default: `/dev/stdout`): sets the path to the admin server logfile
- **ENVOY_XDS_HOST** (default: `127.0.0.1`): sets the xDS server hostname or IP address
- **ENVOY_XDS_PORT** (default: `50000`): sets the xDS server port
- **ENVOY_XDS_CONNECT_TIMEOUT_SECS** (default: `30`): sets the timeout to
  connect to xDS services, in seconds
- **ENVOY_XDS_REFRESH_DELAY_SECS** (default: `10`): sets the delay between calls
  refresh calls to xDS
- **ENVOY_LOG_LEVEL** (default: `info`): sets the log level to one of:
  - `trace`
  - `debug`
  - `info`
  - `warning`
  - `error`
  - `critical`
  - `off`
- **ENVOY_ARGS** (default: none): additional args for the envoy binary

Envoy logs are emitted on STDERR, and by default admin server request logging is
sent to STDOUT.
