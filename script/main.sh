#!/bin/bash

terraform_destroy() {
  terraform destroy
}

action=$1
case "$action" in
  build)
    /bin/bash script/build.sh
    ;;
  destroy)
    terraform_destroy
    ;;
  *)
    echo "Usage: $0 {start|stop}"
esac
