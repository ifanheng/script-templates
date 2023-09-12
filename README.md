# deploy-template.sh 
一个用户部署的bash shell脚本模板

```
# bash deploy-template.sh 
必须携带 -a 参数执行完整部署或者携带 -c 参数执行选择性部署，但不能同时携带 -a 和 -c 参数。

Usage: deploy-template.sh [-u username] [-p password] [-a] [-c components]
Deploy components with optional parameters.

Options:
  -u username   Set the username for deployment (default: default_user).
  -p password   Set the password for deployment (default: default_password).
  -a            Perform a full deployment of all components.
  -c components Specify which components to deploy (comma-separated, e.g., 1,2,3).
  -h            Show this help message.

# bash deploy-template.sh -a 
部署组件1，用户名：default_user，密码：default_password
部署组件2，用户名：default_user，密码：default_password
部署组件3，用户名：default_user，密码：default_password

# bash deploy-template.sh -c 1,3,2
部署组件1，用户名：default_user，密码：default_password
部署组件3，用户名：default_user，密码：default_password
部署组件2，用户名：default_user，密码：default_password

# bash deploy-template.sh -a -c 1
不能同时携带 -a 和 -c 参数。

# bash deploy-template.sh -h

Usage: deploy-template.sh [-u username] [-p password] [-a] [-c components]
Deploy components with optional parameters.

Options:
  -u username   Set the username for deployment (default: default_user).
  -p password   Set the password for deployment (default: default_password).
  -a            Perform a full deployment of all components.
  -c components Specify which components to deploy (comma-separated, e.g., 1,2,3).
  -h            Show this help message.
```
