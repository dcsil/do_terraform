CLUSTER_NAME=dcsil-cluster

echo '==== Fetching K8s cluster config with doctl'
doctl kubernetes cluster kubeconfig save $CLUSTER_NAME

echo '\n==== Fetching Nodes from K8s with kubectl'
kubectl get nodes

echo '\n==== Launching nginx on Kubernetes'
kubectl apply -f k8s/nginx.yml

echo '\n==== Launching a load balancer on Kubernetes'
start_time=$(date +%s) # Start time is actually just before the apply
kubectl apply -f k8s/loadbalancer.yml

clocks=( 🕐 🕜 🕑 🕝 🕒 🕞 🕓 🕟 🕔 🕠 🕕 🕡 🕖 🕢 🕗 🕣 🕘 🕤 🕙 🕥 🕚 🕦 🕛 🕧 )
iteration=0
echo '\n==== Waiting for load balancer to be public. This could take a while'
echo "==== ${clocks[0]} Elapsed time: -"
ip_address="$(kubectl get services | grep '^nginx*' | awk '{ print $(NF-2) }')"
while [ $ip_address == '<pending>' ]
do
  ip_address="$(kubectl get services | grep '^nginx*' | awk '{ print $(NF-2) }')"
  printf '.'

  end_time=$(date +%s)
  elapsed=$(( end_time - start_time ))
  clock_idx=$(($iteration%${#clocks[@]}))
  output="==== ${clocks[$clock_idx]} Elapsed time: $elapsed sec"
  iteration=$(( iteration + 1 ))
  printf "\033[1F$output\033[0E\033[$(echo $iteration)C" # \033[1F moves cursor to the beginning of the line, we end up to the next line due to echo, so \033[0E moves to the beginning of the next line, \033[$(echo $iteration)C moves cursor to the $iterationth character (end of the dots)

  if [ $ip_address == '<pending>' ]
  then
    sleep 5
  fi
done
echo "**** Load balancer is public at http://$ip_address ****"
kubectl describe service nginx
