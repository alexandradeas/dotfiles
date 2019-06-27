#!/bin/bash
if [ $OSTYPE == "linux-gnu" ] ; then
  opsys="linux"
elif [ $OSTYPE == "darwin" ] ; then
  opsys="darwin"
else
  echo "Unable to determine OS type.."
  exit 1
fi

install_kustomize () {
  curl -s \
    https://api.github.com/repos/kubernetes-sigs/kustomize/releases/latest |\
    grep browser_download |\
    grep $opsys |\
    cut -d '"' -f 4 |\
    xargs curl -O -L
  mv kustomize_*_${opsys}_amd64 kustomize
  chmod u+x kustomize
  sudo mv kustomize /usr/local/bin
}

install_skaffold () {
  curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-${opsys}-amd64
  chmod +x skaffold
  sudo mv skaffold /usr/local/bin
}

case $1 in

  kustomize)
    install_kustomize
  ;;
  skaffold)
    install_skaffold
  ;;
  all)
    install_kustomize
    install_skaffold
  ;;
  *)
    echo "Please specify an option to install"
  ;;

esac

