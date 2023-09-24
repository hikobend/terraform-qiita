## ディレクトリ説明
```bash 
.
.github
├── workflows
│   ├── dev_plan.yml # devディレクトリにPlanのCIを追加
│   └── prepare_plan.yml # prepareディレクトリにPlanのCIを追加
├── envs 
│   ├── dev # develop環境
│   │   ├── backend.tf # tfstateを管理
│   │   ├── main.tf # module呼び出し
│   │   ├── provider.tf # providerブロック
│   │   ├── terraform.tfvars # 変数を入力
│   │   └── variables.tf # 変数
│   ├── prd # production環境
│   └── stg # staging環境
├── modules
│   ├── network # ネットワーク
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── oidc # OIDC
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── prepare_tfstate # prepareのtfstateを管理するS3
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── tfstate # devのtfstateを管理するS3
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── prepare # 共通リソース作成
    ├── backend.tf
    ├── main.tf
    ├── provider.tf
    ├── terraform.tfvars
    └── variables.tf

```
※ outputs.tf・variables.tfは空でも作成する

## 実装方法
- state管理は、ベストプラクティスよりDynamoDBとS3で管理 StateLockをかけるため
- CIツールには、tfcmt・tfsec・tflint・Plan・Applyを作成
  - tfcmt : Planでの差分をプルリク内から確認できるようにするツール
  - tfsec : terraformで作成したAWSのリソースをAWSのベストプラクティスの観点からセキュリティ面を診断するツール
  - tflint : terraformのLinter
  - Plan : pushされたコードに対して、作成したリソースがPlanにより、作成できるか検証する
  - Apply : 手動で実行する。リソースを作成するときはローカルで実行せず、ActionsのCIを回して作成する
  - OIDC : AWSの認証をするときはOIDCを使う
- moduleは公式のregistryを採用する
- 公式のregistryを参照しても実装ができない場合、resourceブロックから作成する
- terraformはterraformのベストプラクティスに沿ったコードを記述していく
- AWSのリソースもまた、AWSのベストプラクティスに沿ったリソース作成をする
- terraformのmoduleは「[standard module structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)」に従う
  - main.tf, variables.tf, outputs.tf, locals.tfは空でも作成する
  - readmeで各のmodule内で作成されるリソースとリソースの用途を明記
  - variable, outputにはdescriptionとtypeを追加する

## tfsec
terraformで作成したリソースを、AWSのベストプラクティスの観点からセキュリティを分析するツール https://github.com/aquasecurity/tfsec
- .github/workflows/tfsec.ymlの「Show Result tfsec」でtfsecの内容を確認できる。

## 参考ベストプラクティス
[20 Terraform Best Practices to Improve your TF workflow](https://spacelift.io/blog/terraform-best-practices)
