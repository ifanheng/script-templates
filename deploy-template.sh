#!/bin/bash
# 作者：Adam Fan
# 邮箱：fanhengmail@163.com
# 说明：一个用于部署的bash shell脚本模板

# 默认参数
default_username="default_user"
default_password="default_password"

# 帮助信息函数
function show_help() {
    echo
    echo "Usage: $0 [-u username] [-p password] [-a] [-c components]"
    echo "Deploy components with optional parameters."
    echo ""
    echo "Options:"
    echo "  -u username   Set the username for deployment (default: $default_username)."
    echo "  -p password   Set the password for deployment (default: $default_password)."
    echo "  -a            Perform a full deployment of all components."
    echo "  -c components Specify which components to deploy (comma-separated, e.g., 1,2,3)."
    echo "  -h            Show this help message."
    exit 0
}

# 默认的组件部署函数
function deploy_component1() {
    local username="$1"
    local password="$2"
    echo "部署组件1，用户名：$username，密码：$password"
}

function deploy_component2() {
    local username="$1"
    local password="$2"
    echo "部署组件2，用户名：$username，密码：$password"
}

function deploy_component3() {
    local username="$1"
    local password="$2"
    echo "部署组件3，用户名：$username，密码：$password"
}

# 默认的完整部署函数
function deploy_all_components() {
    local username="$1"
    local password="$2"
    deploy_component1 "$username" "$password"
    deploy_component2 "$username" "$password"
    deploy_component3 "$username" "$password"
}

# 初始化-a参数和-c参数为空
full_deploy=false
components=""

# 使用getopts处理关键字参数
while getopts ":u:p:hac:" opt; do
    case $opt in
        u)
            username="$OPTARG"
            ;;
        p)
            password="$OPTARG"
            ;;
        a)
            full_deploy=true
            ;;
        h)
            show_help
            ;;
        c)
            components="$OPTARG"  # 选择性部署的组件参数，可以是-c 1,2,3，也可以是-c 3,2,1 的组合，会按照传入的 -c 3,1,2这样的位置顺序来执行
            # 检查是否提供了无效的部署组件的数字
            IFS=',' read -ra component_array <<< "$components"
            for component in "${component_array[@]}"; do
                case "$component" in
                    1|2|3)
                        # 组件参数有效
                        ;;
                    *)
                        echo "无效的部署组件的参数数字: $component"
                        exit 1
                        ;;
                esac
            done
            ;;
        \?)
            echo "无效的选项: -$OPTARG"
            exit 1
            ;;
        :)
            echo "选项 -$OPTARG 需要参数."
            exit 1
            ;;
    esac
done

# 检查是否提供了用户名和密码参数，如果没有，则使用默认参数
if [ -z "$username" ]; then
    username="$default_username"
fi

if [ -z "$password" ]; then
    password="$default_password"
fi

# 检查-a和-c参数的有效性
if [ "$full_deploy" = true ] && [ -n "$components" ]; then
    echo "不能同时携带 -a 和 -c 参数。"
    exit 1
fi

# 执行选择性部署或完整部署
if [ "$full_deploy" = true ]; then
    # 执行完整部署
    deploy_all_components "$username" "$password"
elif [ -n "$components" ]; then
    IFS=',' read -ra component_array <<< "$components"
    for component in "${component_array[@]}"; do
        case "$component" in
            1)
                deploy_component1 "$username" "$password"
                ;;
            2)
                deploy_component2 "$username" "$password"
                ;;
            3)
                deploy_component3 "$username" "$password"
                ;;
        esac
    done
else
    echo "必须携带 -a 参数执行完整部署或者携带 -c 参数执行选择性部署，但不能同时携带 -a 和 -c 参数。"
    show_help
    exit 1
fi

