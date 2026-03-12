# Install

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli


# 腾讯云

## 获取密钥

进入右上角“访问管理”，点击左侧菜单“用户”，创建一个新用户，访问方式选择“编程访问”，创建成功后，会得到一个 SecretId 和 SecretKey。

## 配置密钥

```bash
$ export TENCENTCLOUD_SECRET_ID="secretid"
$ export TENCENTCLOUD_SECRET_KEY="secretkey"
$ export TENCENTCLOUD_REGION="ap-hongkong"
```

## 运行

1. 初始化

```bash
$ terraform init
```

2. 预览

```bash
$ terraform plan
```

3. 执行

```bash
$ terraform apply
```

# AWS

## 创建用户和用户组

1. 进入控制台，选择“IAM”产品，点击“用户组”创建新的用户组，在用户组权限策略选择“AdministrotorAccess”，授予管理员权限，点击“创建组”。

2. 进入“用户”菜单，点击“创建用户”，输入用户名后，点击“下一步”，然后选择要关联的用户组，选择上面创建的用户组，点击“下一步”，然后点击“创建用户”。

## 获取密钥

1. 进入“用户”菜单，选择刚才创建的用户进入详情页，选择“安全凭证”标签页，在“访问密钥”中点击“创建访问密钥”，选择“本地代码”，点击下一步。

## 配置密钥

```bash
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_REGION="us-west-2"
```

## 运行

1. 初始化

```bash
$ terraform init
```

2. 预览

```bash
$ terraform plan
```

3. 执行

```bash
$ terraform apply
```