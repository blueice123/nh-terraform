locals{ ## workspace 별로 배포되는 AWS 계정을 여러개로 분리, 이는 provider 에서 정의 됨
    logs            = "${terraform.workspace == "logs"    ? "333003622053": ""}"    # 이주형 님 
    shared          = "${terraform.workspace == "shared"  ? "140646465574": ""}"    # 강병욱 님 
    sec             = "${terraform.workspace == "sec"     ? "968653168360": ""}"    # 박재현 님 
    net             = "${terraform.workspace == "net"     ? "239234376445": ""}"    # 하수용 님 
    audit           = "${terraform.workspace == "net"     ? "709680035562": ""}"    # 유정훈 님 
    prd             = "${terraform.workspace == "prd"     ? "138511064004": ""}"    # 정찬명 님
    mgmt            = "${terraform.workspace == "mgmt"    ? "214269918705": ""}"    # 김현민 님
    account_num     = "${coalesce(local.prd, local.mgmt, local.logs, local.shared, local.sec, local.net, local.audit)}"
}

resource "random_id" "random" {
    byte_length = 4
}
