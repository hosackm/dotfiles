# kubectl
alias k='kubectl'

# get
alias kg='kubectl get'
alias kga='kubectl get all'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'

# describe
alias kd='kubectl describe'
alias kdp='kubectl describe pod'

# apply / delete
alias ka='kubectl apply -f'
alias kdel='kubectl delete'
alias kdelp='kubectl delete pod'

# logs / exec
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias kex='kubectl exec -it'

# context / namespace
alias kctx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'
