data "http" "lbc_iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"

  request_headers = {
    Accept = "application/json"
  }
}

data "aws_iam_policy_document" "lbc_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    effect = "Allow"

    principals {
      type = "Federated"
      identifiers = [
        module.eks.oidc_provider_arn
      ]
    }

    condition {
      test = "ForAnyValue:StringEquals"
      values = [
        "system:serviceaccount:kube-system:aws-load-balancer-controller"
      ]
      variable = "${local.aws_iam_oidc_connect_provider_extract_from_arn}:sub"
    }

    condition {
      test = "ForAnyValue:StringEquals"
      values = [
        "sts.amazonaws.com"
      ]
      variable = "${local.aws_iam_oidc_connect_provider_extract_from_arn}:aud"
    }
  }
}