# Image of RyzenAdj

See [FlyGoat/RyzenAdj](https://github.com/FlyGoat/RyzenAdj) for details.

# Usage

```sh
$ docker run --rm -v /sys:/sys -v /dev:/dev --privileged ghcr.io/googollee/ryzenadj ryzenadj --stapm-limit=35000 --slow-limit=35000 --tctl-temp=90
Sucessfully set stapm_limit to 35000
Sucessfully set slow_limit to 35000
Sucessfully set tctl_temp to 90

$ docker run --rm -v /sys:/sys -v /dev:/dev --privileged ghcr.io/googollee/ryzenadj amdgpu_top
```
