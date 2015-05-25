# ghetto-jails
A really hacky way of offering transient jail shells using docker, because I can.


## Why?
I wanted a quick and easy way to offer jailed shell accounts to guests on a dedicated virtual machine.
Instead of using standard approaches, I was curious how easy it would be to throw together the equivalent using docker.


## How it works
Users SSH into the host machine using a dedicated user account. The users key is preconfigured in the `authorized_keys` file to launch the wrapper script which is responsible for spawning a new docker process in a sandboxed environment for the user.

When the last shell session for the user exits, docker will automatically destroy the container.


## Requirements

-    Linux system with Kernel 
-    Docker tools 1.3 or newer (requires the `exec` subcommand)


## Installation instructions
To get started you need to perform the following steps:

-    Create a system user and add it to the `docker` group: `useradd -r -G docker shell`
-    Clone the repository or copy the `jail.sh` script somewhere into the shell users home directory
-    Create an `authorized_keys` file in the appropriate location

To add new users, you need to add new entries to the authorized_keys file with the following contents:

    command="~shell/jail.sh USERNAME",no-port-forwarding,no-x11-forwarding,no-agent-forwarding KEYTYPE KEY COMMENT"

Where the fields are as follows:

-    `USERNAME` - The name of the user, this is used as the docker image name as well as the guest hostname
-    `KEYTYPE` - The SSH key type
-    `KEY` - The SSH key
-    `COMMENT` - The SSH key comment, if present


## Future features

-    Tools to manage a database of users/keys and environments
-    Integrate the wrapper to launch a different base image depending on user key (eg: bob wants a CentOS guest, larry wants Ubuntu)
-    Allow persistent images for specific users
