# kubectl prompt logic is taken from https://github.com/Ladicle/fish-kubectl-prompt/blob/master/functions/fish_right_prompt.fish
function kubectl_status
    set -l KUBECTL_PROMPT_SEPARATOR ":"
    set -l config "$HOME/.kube/config"

    if [ ! -f $config ]
        echo ""
        return
    end

    set -l context (kubectl config current-context 2>/dev/null)

    if [ $status -ne 0 ]
        echo ""
        return
    end

    set -l namespace (kubectl config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}")

    [ -z $namespace ]; and set -l namespace 'default'

    echo (set_color normal)$context(set_color normal)$KUBECTL_PROMPT_SEPARATOR(set_color cyan)$namespace""
end

function kubectl_prompt
    function fish_prompt
        echo "("(kubectl_status)(set_color normal)")> "
    end
end

function kubectl_namespace -a namespace
    kubectl config set-context --current --namespace=$namespace
end

function kubectl_context -a context
    kubectl config use-context $context
end

function kubectl_bash -a pod
    kubectl exec -it $pod -- /bin/bash
end
