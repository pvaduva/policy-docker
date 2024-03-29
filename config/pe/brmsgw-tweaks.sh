#! /bin/bash
# Copyright 2018 AT&T Intellectual Property. All rights reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PROPS_BUILD="${POLICY_HOME}/etc/build.info"

PROPS_RUNTIME="${POLICY_HOME}/servers/brmsgw/config.properties"
PROPS_INSTALL="${POLICY_HOME}/install/servers/brmsgw/config.properties"


if [ ! -f "${PROPS_BUILD}" ]; then
	echo "error: version information does not exist: ${PROPS_BUILD}"
	exit 1
fi

source "${POLICY_HOME}/etc/build.info"

if [ -z "${version}" ]; then
	echo "error: no version information present"
	exit 1
fi

for CONFIG in ${PROPS_RUNTIME} ${PROPS_INSTALL}; do
	if [ ! -f "${CONFIG}" ]; then
		echo "warning: configuration does not exist: ${CONFIG}"
	else
		sed -i -e "s/brms.dependency.version=.*/brms.dependency.version=${version}/g" "${CONFIG}"
	fi
done
