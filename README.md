
# NJoy Configuration

Configurations for NJoy internal game server.

> [!IMPORTANT]  
> This is an internal project that is exposed publicly for ease of use. It is not designed for anything outside my own usecase and while it might be helpful to others
> its not designed in any way, shape, or form to be used outside of said usecase.

Contains generic system configuration via ansible (applied with ansible-pull) and EarthBuild based images for the game servers themselves.

The use of containers allow servers to be self-contained particually when there are multiple versions of the same base software (such as modded minecraft)

To pull this configuration log onto the remote server, ensure you are running as root and then execute
```shell
ansible-pull -U git@github.com:Vespion/NJoy.git -C main local.yml
```