## Overview

Cookbooks for deploying with OpsWorks will go here.  Recipe implmentation will
basically follow this pattern:

1. Install docker and any of its required dependencies.
2. Execute a `docker run` command to deploy the software.
3. Assuming a locked down system, open any ports necessary for communication.
4. Execute lockdowns on the VM if necessary.

I don't recall there being a docker resource/provider that is provided out of the box by
Chef, so I will probably create my own resource/provider to handle any docker
commands rather than just "shelling out" in the middle of a Chef recipe.
